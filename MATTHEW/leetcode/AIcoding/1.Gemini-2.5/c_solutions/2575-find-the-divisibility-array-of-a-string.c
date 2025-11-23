#include <stdlib.h>
#include <string.h>

int* divisibilityArray(char* word, int m, int* returnSize) {
    int n = strlen(word);
    *returnSize = n;
    int* ans = (int*)malloc(sizeof(int) * n);

    long long current_remainder = 0;

    for (int i = 0; i < n; i++) {
        current_remainder = (current_remainder * 10 + (word[i] - '0')) % m;
        if (current_remainder == 0) {
            ans[i] = 1;
        } else {
            ans[i] = 0;
        }
    }

    return ans;
}