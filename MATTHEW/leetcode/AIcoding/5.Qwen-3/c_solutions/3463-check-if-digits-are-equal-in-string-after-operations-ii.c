#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canMakeEqual(char* s) {
    int count[26] = {0};
    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        count[s[i] - 'a']++;
    }
    int gcd_val = 0;
    for (int i = 0; i < 26; i++) {
        if (count[i] > 0) {
            gcd_val = count[i];
            break;
        }
    }
    for (int i = 0; i < 26; i++) {
        if (count[i] > 0) {
            int a = gcd_val;
            int b = count[i];
            while (b) {
                int temp = b;
                b = a % b;
                a = temp;
            }
            gcd_val = a;
        }
    }
    for (int i = 0; i < 26; i++) {
        if (count[i] % gcd_val != 0) {
            return false;
        }
    }
    return true;
}