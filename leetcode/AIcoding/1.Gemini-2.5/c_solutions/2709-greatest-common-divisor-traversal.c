#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

#define MAX_NUM_VAL 100000
#define MAX_NUMS_LEN 100000

static int parent[MAX_NUMS_LEN + MAX_NUM_VAL + 1];
static int sz[MAX_NUMS_LEN + MAX_NUM_VAL + 1];
static int spf[MAX_NUM_VAL + 1];

int find(int i) {
    if (parent[i] == i)
        return i;
    return parent[i] = find(parent[i]);
}

void unite(int i, int j) {
    int root_i = find(i);
    int root_j = find(j);
    if (root_i != root_j) {
        if (sz[root_i] < sz[root_j]) {
            int temp = root_i;
            root_i = root_j;
            root_j = temp;
        }
        parent[root_j] = root_i;
        sz[root_i] += sz[root_j];
    }
}

void sieve(int max_val) {
    for (int i = 0; i <= max_val; ++i) {
        spf[i] = i;
    }
    for (int i = 2; i * i <= max_val; ++i) {
        if (spf[i] == i) {
            for (int j = i * i; j <= max_val; j += i) {
                if (spf[j] == j) {
                    spf[j] = i;
                }
            }
        }
    }
}

bool canTraverseAllPairs(int* nums, int numsSize) {
    if (numsSize == 1) {
        return true;
    }

    int max_val = 0;
    bool has_one = false;
    for (int i = 0; i < numsSize; ++i) {
        if (nums[i] == 1) {
            has_one = true;
        }
        if (nums[i] > max_val) {
            max_val = nums[i];
        }
    }

    if (has_one) {
        return false;
    }

    sieve(max_val);

    int dsu_elements = numsSize + max_val + 1;
    for (int i = 0; i < dsu_elements; ++i) {
        parent[i] = i;
        sz[i] = 1;
    }

    for (int i = 0; i < numsSize; ++i) {
        int num = nums[i];
        while (num > 1) {
            int p = spf[num];
            unite(i, numsSize + p);
            while (num > 0 && num % p == 0) { // num > 0 check to prevent infinite loop if num becomes 0 due to error
                num /= p;
            }
        }
    }

    int root_of_first_element = find(0);
    for (int i = 1; i < numsSize; ++i) {
        if (find(i) != root_of_first_element) {
            return false;
        }
    }

    return true;
}