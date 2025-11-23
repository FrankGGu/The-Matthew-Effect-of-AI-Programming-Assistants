#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countPalindromicSubseq(int* arr, int n) {
    int count[26][26][26] = {0};
    int result = 0;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            for (int k = j + 1; k < n; k++) {
                if (arr[i] == arr[k]) {
                    count[arr[i]][arr[j]][arr[k]]++;
                }
            }
        }
    }
    for (int i = 0; i < 26; i++) {
        for (int j = 0; j < 26; j++) {
            for (int k = 0; k < 26; k++) {
                if (count[i][j][k] > 0) {
                    result += count[i][j][k];
                }
            }
        }
    }
    return result;
}

int uniqueLength3PalindromicSubsequences(char* s) {
    int n = strlen(s);
    int* arr = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        arr[i] = s[i] - 'a';
    }
    int result = countPalindromicSubseq(arr, n);
    free(arr);
    return result;
}