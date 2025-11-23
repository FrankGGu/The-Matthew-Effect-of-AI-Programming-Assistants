#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* data;
    int size;
} Array;

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int min(int a, int b) {
    return a < b ? a : b;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int get_hash(int* arr, int len, int base, int mod) {
    int hash = 0;
    for (int i = 0; i < len; i++) {
        hash = (hash * base + arr[i]) % mod;
    }
    return hash;
}

int* create_array(int size) {
    int* arr = (int*)malloc(size * sizeof(int));
    return arr;
}

int findLongestCommonSubpath(int** paths, int pathsSize, int* pathSizes, int* returnSize) {
    int n = pathsSize;
    int min_len = pathSizes[0];
    for (int i = 1; i < n; i++) {
        min_len = min(min_len, pathSizes[i]);
    }

    int base = 1000003;
    int mod = 1000000007;

    int* common = NULL;
    int common_len = 0;

    for (int l = min_len; l >= 1; l--) {
        int* hash_set = (int*)calloc(1 << 20, sizeof(int));
        int hash_count = 0;

        for (int i = 0; i < n; i++) {
            int* path = paths[i];
            int len = pathSizes[i];

            int current_hash = 0;
            for (int j = 0; j < l; j++) {
                current_hash = (current_hash * base + path[j]) % mod;
            }

            if (hash_set[current_hash] == 0) {
                hash_set[current_hash] = 1;
                hash_count++;
            }

            for (int j = l; j < len; j++) {
                current_hash = (current_hash * base + path[j] - path[j - l] * base) % mod;
                if (current_hash < 0) current_hash += mod;
                if (hash_set[current_hash] == 0) {
                    hash_set[current_hash] = 1;
                    hash_count++;
                }
            }
        }

        if (hash_count == n) {
            common_len = l;
            break;
        }

        free(hash_set);
    }

    *returnSize = common_len;
    return common;
}