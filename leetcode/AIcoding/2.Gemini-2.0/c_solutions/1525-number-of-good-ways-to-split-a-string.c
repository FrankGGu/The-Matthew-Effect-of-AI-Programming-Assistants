#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numSplits(char * s){
    int n = 0;
    while (s[n] != '\0') {
        n++;
    }
    int left[n];
    int right[n];
    int left_count[26] = {0};
    int right_count[26] = {0};
    int left_distinct = 0;
    int right_distinct = 0;

    for (int i = 0; i < n; i++) {
        int index = s[i] - 'a';
        if (left_count[index] == 0) {
            left_distinct++;
        }
        left_count[index]++;
        left[i] = left_distinct;
    }

    for (int i = n - 1; i >= 0; i--) {
        int index = s[i] - 'a';
        if (right_count[index] == 0) {
            right_distinct++;
        }
        right_count[index]++;
        right[i] = right_distinct;
    }

    int count = 0;
    for (int i = 0; i < n - 1; i++) {
        if (left[i] == right[i + 1]) {
            count++;
        }
    }

    return count;
}