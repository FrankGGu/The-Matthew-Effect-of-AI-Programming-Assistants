#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int jianZhiShu(char* s) {
    int n = strlen(s);
    int* left = (int*)malloc(n * sizeof(int));
    int* right = (int*)malloc(n * sizeof(int));

    left[0] = (s[0] == 'B') ? 1 : 0;
    for (int i = 1; i < n; i++) {
        left[i] = left[i - 1] + (s[i] == 'B' ? 1 : 0);
    }

    right[n - 1] = (s[n - 1] == 'B') ? 1 : 0;
    for (int i = n - 2; i >= 0; i--) {
        right[i] = right[i + 1] + (s[i] == 'B' ? 1 : 0);
    }

    int min = n;
    for (int i = 0; i < n; i++) {
        int total = left[i] + right[i];
        if (total < min) {
            min = total;
        }
    }

    free(left);
    free(right);
    return min;
}

int main() {
    char* s = "WBBWB";
    printf("%d\n", jianZhiShu(s));
    return 0;
}