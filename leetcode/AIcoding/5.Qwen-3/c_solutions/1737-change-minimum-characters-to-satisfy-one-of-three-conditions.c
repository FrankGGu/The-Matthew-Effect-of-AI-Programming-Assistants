#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minChanges(char* a, char* b) {
    int countA[26] = {0};
    int countB[26] = {0};
    int lenA = strlen(a);
    int lenB = strlen(b);

    for (int i = 0; i < lenA; i++) {
        countA[a[i] - 'a']++;
    }

    for (int i = 0; i < lenB; i++) {
        countB[b[i] - 'a']++;
    }

    int maxCommon = 0;
    for (int i = 0; i < 26; i++) {
        maxCommon += (countA[i] < countB[i]) ? countA[i] : countB[i];
    }

    int option1 = lenA + lenB - 2 * maxCommon;

    int maxFreqA = 0;
    for (int i = 0; i < 26; i++) {
        maxFreqA = (countA[i] > maxFreqA) ? countA[i] : maxFreqA;
    }

    int maxFreqB = 0;
    for (int i = 0; i < 26; i++) {
        maxFreqB = (countB[i] > maxFreqB) ? countB[i] : maxFreqB;
    }

    int option2 = (lenA - maxFreqA) + (lenB - maxFreqB);

    int option3 = 0;
    for (int i = 0; i < 26; i++) {
        if (countA[i] > 0 && countB[i] > 0) {
            option3++;
        }
    }

    option3 = (lenA - option3) + (lenB - option3);

    return (option1 < option2) ? (option1 < option3 ? option1 : option3) : (option2 < option3 ? option2 : option3);
}