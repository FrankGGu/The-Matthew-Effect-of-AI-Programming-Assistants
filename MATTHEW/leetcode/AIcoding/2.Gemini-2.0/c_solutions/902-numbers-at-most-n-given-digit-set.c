#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int atMostNGivenDigitSet(char** digits, int digitsSize, int n) {
    char nStr[11];
    sprintf(nStr, "%d", n);
    int nLen = strlen(nStr);
    int ans = 0;

    for (int i = 1; i < nLen; i++) {
        ans += (int)pow(digitsSize, i);
    }

    for (int i = 0; i < nLen; i++) {
        int hasSame = 0;
        for (int j = 0; j < digitsSize; j++) {
            if (digits[j][0] < nStr[i]) {
                ans += (int)pow(digitsSize, nLen - i - 1);
            } else if (digits[j][0] == nStr[i]) {
                hasSame = 1;
                if (i == nLen - 1) {
                    ans++;
                }
            }
        }
        if (!hasSame) {
            return ans;
        }
    }

    return ans;
}