#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxConsecutiveAnswers(char * answerKey, int k) {
    int n = 0;
    while (answerKey[n] != '\0') {
        n++;
    }

    int maxFreq(char ch) {
        int left = 0, right = 0, count = 0, maxLen = 0;
        while (right < n) {
            if (answerKey[right] != ch) {
                count++;
            }
            while (count > k) {
                if (answerKey[left] != ch) {
                    count--;
                }
                left++;
            }
            maxLen = (maxLen > right - left + 1) ? maxLen : right - left + 1;
            right++;
        }
        return maxLen;
    }

    int maxT = maxFreq('T');
    int maxF = maxFreq('F');

    return (maxT > maxF) ? maxT : maxF;
}