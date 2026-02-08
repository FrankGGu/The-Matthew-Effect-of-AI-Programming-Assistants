#include <stdlib.h>
#include <string.h>
#include <math.h>

int* parent;
int* rank_arr;

int find(int i) {
    if (parent[i] == i) {
        return i;
    }
    return parent[i] = find(parent[i]);
}

void unite(int i, int j) {
    int root_i = find(i);
    int root_j = find(j);

    if (root_i != root_j) {
        if (rank_arr[root_i] < rank_arr[root_j]) {
            parent[root_i] = root_j;
        } else if (rank_arr[root_i] > rank_arr[root_j]) {
            parent[root_j] = root_i;
        } else {
            parent[root_j] = root_i;
            rank_arr[root_i]++;
        }
    }
}

int largestComponentSize(int* nums, int numsSize) {
    int max_val = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max_val) {
            max_val = nums[i];
        }
    }

    parent = (int*)malloc((max_val + 1) * sizeof(int));
    rank_arr = (int*)malloc((max_val + 1) * sizeof(int));

    for (int i = 0; i <= max_val; i++) {
        parent[i] = i;
        rank_arr[i] = 0;
    }

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        if (num == 1) continue;

        for (int j = 2; j * j <= num; j++) {
            if (num % j == 0) {
                unite(num, j);
                unite(num, num / j);
            }
        }
    }

    int* component_size = (int*)calloc((max_val + 1), sizeof(int));
    int max_component_size = 0;

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        int root = find(num);
        component_size[root]++;
        if (component_size[root] > max_component_size) {
            max_component_size = component_size[root];
        }
    }

    free(parent);
    free(rank_arr);
    free(component_size);

    return max_component_size;
}