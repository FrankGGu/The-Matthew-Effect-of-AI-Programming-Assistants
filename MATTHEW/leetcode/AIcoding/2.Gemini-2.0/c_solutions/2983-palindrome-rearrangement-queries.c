#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 100005
#define MAXQ 100005
#define MAXALPHA 26

int tree[MAXN][MAXALPHA];
int n;

void update(int idx, int alpha, int val) {
    for (; idx <= n; idx += (idx & -idx)) {
        tree[idx][alpha] += val;
    }
}

int query(int idx, int alpha) {
    int sum = 0;
    for (; idx > 0; idx -= (idx & -idx)) {
        sum += tree[idx][alpha];
    }
    return sum;
}

int get_range_sum(int l, int r, int alpha) {
    return query(r, alpha) - query(l - 1, alpha);
}

bool can_rearrange(int l, int r, int k) {
    int odd_count = 0;
    for (int i = 0; i < MAXALPHA; i++) {
        if (get_range_sum(l, r, i) % 2 != 0) {
            odd_count++;
        }
    }
    return odd_count <= 2 * k + 1;
}

bool* canMakePaliQueries(char * s, int** queries, int queriesSize, int* queriesColSize, int* returnSize){
    n = strlen(s);

    for (int i = 0; i <= n; i++) {
        for (int j = 0; j < MAXALPHA; j++) {
            tree[i][j] = 0;
        }
    }

    for (int i = 1; i <= n; i++) {
        update(i, s[i - 1] - 'a', 1);
    }

    bool* result = (bool*)malloc(queriesSize * sizeof(bool));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int l = queries[i][0] + 1;
        int r = queries[i][1] + 1;
        int k = queries[i][2];
        result[i] = can_rearrange(l, r, k);
    }

    return result;
}