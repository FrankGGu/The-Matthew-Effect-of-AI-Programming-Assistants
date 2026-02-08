#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

void swap(char* a, char* b) {
    char temp = *a;
    *a = *b;
    *b = temp;
}

void reverse(char* s, int start, int end) {
    while (start < end) {
        swap(&s[start], &s[end]);
        start++;
        end--;
    }
}

void nextPermutation(char* s) {
    int len = strlen(s);
    int i = len - 2;
    while (i >= 0 && s[i] >= s[i + 1]) {
        i--;
    }
    if (i >= 0) {
        int j = len - 1;
        while (j > i && s[j] <= s[i]) {
            j--;
        }
        swap(&s[i], &s[j]);
    }
    reverse(s, i + 1, len - 1);
}

int getMinSwaps(char* num, char* target) {
    int len = strlen(num);
    int swaps = 0;
    char* temp = (char*)malloc((len + 1) * sizeof(char));
    strcpy(temp, num);

    for (int i = 0; i < len; i++) {
        if (temp[i] != target[i]) {
            int j = i + 1;
            while (j < len && temp[j] != target[i]) {
                j++;
            }
            while (j > i) {
                swap(&temp[j], &temp[j - 1]);
                swaps++;
                j--;
            }
        }
    }
    free(temp);
    return swaps;
}

int getMinSwaps(char* num, int k) {
    char* target = (char*)malloc((strlen(num) + 1) * sizeof(char));
    strcpy(target, num);

    for (int i = 0; i < k; i++) {
        nextPermutation(target);
    }

    int result = getMinSwaps(num, target);
    free(target);
    return result;
}