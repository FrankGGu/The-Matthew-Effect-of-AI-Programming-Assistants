#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

bool areSentencesSimilar(char* sentence1, char* sentence2) {
    char* words1[100];
    char* words2[100];
    int count1 = 0, count2 = 0;

    char* token = strtok(sentence1, " ");
    while (token != NULL) {
        words1[count1++] = token;
        token = strtok(NULL, " ");
    }

    token = strtok(sentence2, " ");
    while (token != NULL) {
        words2[count2++] = token;
        token = strtok(NULL, " ");
    }

    if (count1 < count2) {
        char** temp = words1;
        words1 = words2;
        words2 = temp;
        int tempCount = count1;
        count1 = count2;
        count2 = tempCount;
    }

    int left = 0;
    while (left < count2 && strcmp(words1[left], words2[left]) == 0) {
        left++;
    }

    int right = 0;
    while (right < count2 && strcmp(words1[count1 - 1 - right], words2[count2 - 1 - right]) == 0) {
        right++;
    }

    return left + right >= count2;
}