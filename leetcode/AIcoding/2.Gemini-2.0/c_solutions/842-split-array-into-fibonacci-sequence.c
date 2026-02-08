#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool backtrack(char *s, int index, int *seq, int seq_size, int *result, int *result_size) {
    if (index == strlen(s)) {
        if (seq_size >= 3) {
            *result_size = seq_size;
            for (int i = 0; i < seq_size; i++) {
                result[i] = seq[i];
            }
            return true;
        }
        return false;
    }

    long long num = 0;
    for (int i = index; i < strlen(s); i++) {
        if (s[index] == '0' && i > index) break;
        num = num * 10 + (s[i] - '0');
        if (num > INT_MAX) break;

        if (seq_size < 2 || (long long)seq[seq_size - 1] + (long long)seq[seq_size - 2] == num) {
            seq[seq_size] = (int)num;
            if (backtrack(s, i + 1, seq, seq_size + 1, result, result_size)) {
                return true;
            }
        }
    }
    return false;
}

int* splitIntoFibonacci(char * s, int* returnSize){
    int *seq = (int*)malloc(sizeof(int) * strlen(s));
    int *result = (int*)malloc(sizeof(int) * strlen(s));
    int result_size = 0;

    if (backtrack(s, 0, seq, 0, result, &result_size)) {
        *returnSize = result_size;
        free(seq);
        return result;
    } else {
        *returnSize = 0;
        free(seq);
        free(result);
        return NULL;
    }
}