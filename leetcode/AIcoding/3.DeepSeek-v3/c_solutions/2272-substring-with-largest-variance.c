#include <stdlib.h>
#include <string.h>

int largestVariance(char* s) {
    int n = strlen(s);
    int count[26] = {0};
    for (int i = 0; i < n; i++) {
        count[s[i] - 'a']++;
    }

    int maxVariance = 0;

    for (char a = 'a'; a <= 'z'; a++) {
        for (char b = 'a'; b <= 'z'; b++) {
            if (a == b || count[a - 'a'] == 0 || count[b - 'a'] == 0) {
                continue;
            }

            int countA = 0, countB = 0;
            int remainingB = count[b - 'a'];

            for (int i = 0; i < n; i++) {
                if (s[i] == a) {
                    countA++;
                } else if (s[i] == b) {
                    countB++;
                    remainingB--;
                }

                if (countB > 0) {
                    int variance = countA - countB;
                    if (variance > maxVariance) {
                        maxVariance = variance;
                    }
                }

                if (countA < countB && remainingB > 0) {
                    countA = 0;
                    countB = 0;
                }
            }
        }
    }

    return maxVariance;
}