#include <stdlib.h>

#define MAX_N 20001

int parent[MAX_N];
int size[MAX_N];

int find(int x) {
    if (parent[x] != x) {
        parent[x] = find(parent[x]);
    }
    return parent[x];
}

void unite(int x, int y) {
    int rootX = find(x);
    int rootY = find(y);
    if (rootX != rootY) {
        if (size[rootX] < size[rootY]) {
            parent[rootX] = rootY;
            size[rootY] += size[rootX];
        } else {
            parent[rootY] = rootX;
            size[rootX] += size[rootY];
        }
    }
}

int largestComponentSize(int* nums, int numsSize) {
    int max_val = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max_val) max_val = nums[i];
    }

    for (int i = 0; i <= max_val; i++) {
        parent[i] = i;
        size[i] = 1;
    }

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        for (int factor = 2; factor * factor <= num; factor++) {
            if (num % factor == 0) {
                unite(num, factor);
                unite(num, num / factor);
            }
        }
    }

    int count[MAX_N] = {0};
    int max_component = 0;
    for (int i = 0; i < numsSize; i++) {
        int root = find(nums[i]);
        count[root]++;
        if (count[root] > max_component) {
            max_component = count[root];
        }
    }

    return max_component;
}