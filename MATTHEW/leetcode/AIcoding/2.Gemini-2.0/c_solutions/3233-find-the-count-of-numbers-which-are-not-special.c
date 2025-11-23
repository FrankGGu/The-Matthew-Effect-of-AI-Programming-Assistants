#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countNumbers(int n) {
    char s[11];
    sprintf(s, "%d", n);
    int len = strlen(s);
    int ans = 0;
    int available[10] = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1};
    int fact[11];
    fact[0] = 1;
    for (int i = 1; i <= 10; i++) {
        fact[i] = fact[i - 1] * i;
    }

    for (int i = 1; i < len; i++) {
        int temp = 9;
        for (int j = 1; j < i; j++) {
            temp--;
        }
        int num = 9;
        for (int k = 0; k < i - 1; k++) {
            num *= (9 - k);
        }
        ans += num;
    }

    int used[10] = {0};
    for (int i = 0; i < len; i++) {
        int digit = s[i] - '0';
        int count = 0;
        for (int j = (i == 0 ? 1 : 0); j < digit; j++) {
            if (available[j]) {
                count++;
            }
        }
        int remaining = len - i - 1;
        int numerator = 1;
        int denominator = 1;
        int temp = 10 - (i + 1);
        for(int k = 0; k < remaining; k++){
            numerator *= (temp - k);
        }

        ans += count * numerator;
        if (!available[digit]) {
            break;
        }
        available[digit] = 0;
        if (i == len - 1) {
            ans++;
        }
    }

    return n - ans;
}