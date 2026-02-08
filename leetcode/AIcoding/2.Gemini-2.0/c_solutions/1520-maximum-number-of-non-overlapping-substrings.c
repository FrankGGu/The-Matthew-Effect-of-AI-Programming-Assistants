#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* solve(char* s, int* returnSize) {
    int n = strlen(s);
    int left[26], right[26];
    for (int i = 0; i < 26; i++) {
        left[i] = n;
        right[i] = -1;
    }
    for (int i = 0; i < n; i++) {
        int c = s[i] - 'a';
        left[c] = (left[c] < i) ? left[c] : i;
        right[c] = (right[c] > i) ? right[c] : i;
    }

    int ans_size = 0;
    int* ans = (int*)malloc(n * sizeof(int));
    *returnSize = 0;

    int i = 0;
    while (i < n) {
        int start = i;
        int end = right[s[i] - 'a'];
        for (int j = start; j < end; j++) {
            int c = s[j] - 'a';
            if (left[c] < start) {
                i++;
                goto next_substring;
            }
            end = (end > right[c]) ? end : right[c];
        }
        ans[ans_size++] = start;
        ans[ans_size++] = end;
        *returnSize += 1;
        i = end + 1;

        next_substring:;
    }

    int* res = (int*)malloc(*returnSize * (end+1) * sizeof(int));
    int k = 0;
    for (int i = 0; i < *returnSize; i++) {
        int start = ans[2*i];
        int end = ans[2*i+1];
        for(int j = start; j <= end; j++){
            res[k++] = (int)s[j];
        }
        res[k++] = -1;
    }

    *returnSize = k;
    return res;
}