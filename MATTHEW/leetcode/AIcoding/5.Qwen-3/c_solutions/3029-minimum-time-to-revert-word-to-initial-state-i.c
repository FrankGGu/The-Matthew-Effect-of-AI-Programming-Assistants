#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumTimeToInitialState(char* word, int k) {
    int n = strlen(word);
    int time = 0;
    int i = 0;
    while (i < n) {
        i += k;
        time++;
        if (i >= n) break;
        int j = 0;
        while (j < n - i && word[j] == word[j + i]) {
            j++;
        }
        if (j == n - i) break;
    }
    return time;
}