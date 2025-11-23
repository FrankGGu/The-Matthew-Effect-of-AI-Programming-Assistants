#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minTimeToType(char* word) {
    int time = 0;
    int prev = 0;
    for (int i = 0; i < strlen(word); i++) {
        int curr = word[i] - 'a';
        int diff = abs(curr - prev);
        time += diff < 26 - diff ? diff : 26 - diff;
        prev = curr;
    }
    return time;
}