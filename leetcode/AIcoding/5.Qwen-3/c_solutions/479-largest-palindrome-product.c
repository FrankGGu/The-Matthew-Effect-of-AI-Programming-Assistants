#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

int largestPalindrome(int n) {
    if (n == 1) return 9;

    int max = pow(10, n) - 1;
    int min = pow(10, n - 1);

    for (int i = max; i >= min; i--) {
        long long left = i;
        long long right = 0;
        long long num = i;

        while (num > 0) {
            right = right * 10 + num % 10;
            num /= 10;
        }

        long long palindrome = left * pow(10, n) + right;

        for (int j = max; j >= min; j--) {
            if (palindrome / j > max) break;
            if (palindrome % j == 0) {
                return (int)palindrome;
            }
        }
    }

    return -1;
}