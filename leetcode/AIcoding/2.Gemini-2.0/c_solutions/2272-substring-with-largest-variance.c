#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int largestVariance(char * s){
    int n = strlen(s);
    int ans = 0;
    for (char a = 'a'; a <= 'z'; a++) {
        for (char b = 'a'; b <= 'z'; b++) {
            if (a == b) continue;
            int countA = 0, countB = 0;
            int variance = 0;
            int firstB = 0;

            for (int i = 0; i < n; i++) {
                if (s[i] == a) {
                    countA++;
                } else if (s[i] == b) {
                    countB++;
                    firstB = 1;
                }

                if (countB > 0) {
                    variance = countA - countB;
                    if (variance < 0) {
                        countA = 0;
                        countB = 0;
                    }
                    ans = (ans > variance) ? ans : variance;
                }
            }

            countA = 0, countB = 0;
            variance = 0;

            for (int i = n - 1; i >= 0; i--) {
                if (s[i] == a) {
                    countA++;
                } else if (s[i] == b) {
                    countB++;
                }

                if (countB > 0) {
                    variance = countA - countB;
                    if (variance < 0) {
                        countA = 0;
                        countB = 0;
                    }
                    ans = (ans > variance) ? ans : variance;
                }
            }

            int checkA = 0, checkB = 0;
            for (int i = 0; i < n; i++) {
                if (s[i] == a) checkA = 1;
                if (s[i] == b) checkB = 1;
            }

            if (checkA == 0 || checkB == 0) continue;

        }
    }
    return ans;
}