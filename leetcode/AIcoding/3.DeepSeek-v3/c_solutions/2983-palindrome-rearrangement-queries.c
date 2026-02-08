#include <string.h>
#include <stdbool.h>

bool canMakePalindromeQueries(char* s, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int n = strlen(s);
    int m = n / 2;
    char* t = s + m;

    int diff[m + 1];
    diff[0] = 0;
    for (int i = 0; i < m; i++) {
        diff[i + 1] = diff[i] + (s[i] != s[n - 1 - i]);
    }

    int prefix[m + 1];
    int suffix[m + 1];
    prefix[0] = 0;
    for (int i = 0; i < m; i++) {
        prefix[i + 1] = prefix[i] + (s[i] != t[m - 1 - i]);
    }
    suffix[m] = 0;
    for (int i = m - 1; i >= 0; i--) {
        suffix[i] = suffix[i + 1] + (s[i] != t[m - 1 - i]);
    }

    bool* res = malloc(queriesSize * sizeof(bool));
    *returnSize = queriesSize;

    for (int idx = 0; idx < queriesSize; idx++) {
        int a = queries[idx][0], b = queries[idx][1];
        int c = n - 1 - queries[idx][3], d = n - 1 - queries[idx][2];

        if (a > c) {
            int temp = a;
            a = c;
            c = temp;
            temp = b;
            b = d;
            d = temp;
        }

        if (b < c) {
            int left = diff[a];
            int mid = prefix[c] - prefix[b + 1];
            int right = diff[m] - diff[d + 1];
            res[idx] = (left + mid + right) == 0;
        } else {
            int left = diff[a];
            int right = diff[m] - diff[d + 1];
            int overlap = prefix[d + 1] - prefix[b];
            if (b < d) {
                overlap = prefix[d + 1] - prefix[b];
            } else {
                overlap = prefix[b + 1] - prefix[d];
            }
            res[idx] = (left + right + overlap) == 0;
        }
    }

    return res;
}