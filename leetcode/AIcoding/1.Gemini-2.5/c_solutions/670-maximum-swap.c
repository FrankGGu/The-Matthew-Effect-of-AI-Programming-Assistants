#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int maximumSwap(int num) {
    char s[12]; // Max 9 digits for 10^8, plus null terminator, buffer for safety
    sprintf(s, "%d", num);
    int n = strlen(s);

    for (int i = 0; i < n; i++) {
        int max_digit_val = -1; // Represents no digit found yet, or a value smaller than '0'
        int max_digit_idx = -1;

        // Find the largest digit to the right of s[i], prioritizing the rightmost one
        for (int j = n - 1; j > i; j--) {
            if (s[j] > max_digit_val) {
                max_digit_val = s[j];
                max_digit_idx = j;
            }
        }

        // If a digit was found to the right that is larger than s[i], perform the swap
        if (max_digit_idx != -1 && max_digit_val > s[i]) {
            char temp = s[i];
            s[i] = s[max_digit_idx];
            s[max_digit_idx] = temp;
            return atoi(s);
        }
    }

    // If no swap was made, the number is already in maximum swap form
    return num;
}