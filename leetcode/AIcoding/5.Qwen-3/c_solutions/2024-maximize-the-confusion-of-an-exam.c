#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxConsecutiveAnswers(char* answerKey, int k) {
    int left = 0;
    int maxLen = 0;
    int countT = 0;
    int countF = 0;

    for (int right = 0; right < strlen(answerKey); right++) {
        if (answerKey[right] == 'T') countT++;
        else countF++;

        while (countT > k && countF > k) {
            if (answerKey[left] == 'T') countT--;
            else countF--;
            left++;
        }

        maxLen = fmax(maxLen, right - left + 1);
    }

    return maxLen;
}