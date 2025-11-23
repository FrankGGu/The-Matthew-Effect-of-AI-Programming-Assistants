#include <string.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int calculateMaxConfusion(char* answerKey, int k, char targetChar) {
    int n = strlen(answerKey);
    int left = 0;
    int maxLen = 0;
    int charCount = 0;

    for (int right = 0; right < n; right++) {
        if (answerKey[right] == targetChar) {
            charCount++;
        }

        while ((right - left + 1) - charCount > k) {
            if (answerKey[left] == targetChar) {
                charCount--;
            }
            left++;
        }

        maxLen = max(maxLen, right - left + 1);
    }
    return maxLen;
}

int maxConsecutiveAnswers(char* answerKey, int k) {
    int maxT = calculateMaxConfusion(answerKey, k, 'T');
    int maxF = calculateMaxConfusion(answerKey, k, 'F');

    return max(maxT, maxF);
}