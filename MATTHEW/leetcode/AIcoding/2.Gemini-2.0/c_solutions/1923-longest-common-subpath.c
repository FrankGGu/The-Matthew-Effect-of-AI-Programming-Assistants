#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007
#define BASE 29

int power(int base, int exp) {
    long long res = 1;
    long long b = base;
    while (exp > 0) {
        if (exp % 2 == 1) {
            res = (res * b) % MOD;
        }
        b = (b * b) % MOD;
        exp /= 2;
    }
    return (int)res;
}

int check(int len, int **paths, int pathsSize, int *pathsColSize, int n) {
    if (len == 0) return 1;

    int first_path_size = pathsColSize[0];
    if (first_path_size < len) return 0;

    unsigned long long hash_val = 0;
    for (int i = 0; i < len; i++) {
        hash_val = (hash_val * BASE + paths[0][i]) % MOD;
    }

    int power_len = power(BASE, len - 1);

    int hash_set[100001] = {0};
    hash_set[hash_val % 100001] = 1;

    int count = 0;
    for (int i = 0; i < first_path_size - len + 1; i++) {
        if (i > 0) {
            hash_val = (hash_val - (long long)paths[0][i - 1] * power_len % MOD + MOD) % MOD;
            hash_val = (hash_val * BASE + paths[0][i + len - 1]) % MOD;
        }
        if (hash_set[hash_val % 100001] != 1) {
            hash_set[hash_val % 100001] = 1;
            count++;
        }
    }

    int valid[100001] = {0};

    hash_val = 0;
    for (int i = 0; i < len; i++) {
        hash_val = (hash_val * BASE + paths[0][i]) % MOD;
    }

    for (int i = 0; i < first_path_size - len + 1; i++) {
        if (i > 0) {
            hash_val = (hash_val - (long long)paths[0][i - 1] * power_len % MOD + MOD) % MOD;
            hash_val = (hash_val * BASE + paths[0][i + len - 1]) % MOD;
        }
        valid[hash_val % 100001]++;
    }

    for (int k = 1; k < pathsSize; k++) {
        int path_size = pathsColSize[k];
        if (path_size < len) return 0;

        int current_valid[100001] = {0};
        hash_val = 0;
        for (int i = 0; i < len; i++) {
            hash_val = (hash_val * BASE + paths[k][i]) % MOD;
        }

        for (int i = 0; i < path_size - len + 1; i++) {
            if (i > 0) {
                hash_val = (hash_val - (long long)paths[k][i - 1] * power_len % MOD + MOD) % MOD;
                hash_val = (hash_val * BASE + paths[k][i + len - 1]) % MOD;
            }
            if(hash_set[hash_val % 100001] == 1)
                current_valid[hash_val % 100001]++;
        }

        for(int i = 0; i < 100001; i++){
            if(current_valid[i] == 0) valid[i] = 0;
        }
    }

    for(int i = 0; i < 100001; i++){
        if(valid[i] > 0) return 1;
    }

    return 0;
}

int longestCommonSubpath(int n, int **paths, int pathsSize, int *pathsColSize) {
    int min_len = pathsColSize[0];
    for (int i = 1; i < pathsSize; i++) {
        if (pathsColSize[i] < min_len) {
            min_len = pathsColSize[i];
        }
    }

    int low = 0;
    int high = min_len;
    int ans = 0;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (check(mid, paths, pathsSize, pathsColSize, n)) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return ans;
}