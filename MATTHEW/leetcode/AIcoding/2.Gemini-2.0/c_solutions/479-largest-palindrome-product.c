#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int largestPalindrome(int n) {
    if (n == 1) return 9;

    long long max_num = pow(10, n) - 1;
    long long min_num = pow(10, n - 1);

    for (long long i = max_num; i >= min_num; i--) {
        long long palindrome = i;
        long long temp = i;
        while (temp > 0) {
            palindrome = palindrome * 10 + temp % 10;
            temp /= 10;
        }

        for (long long j = max_num; j * j >= palindrome; j--) {
            if (palindrome % j == 0 && palindrome / j >= min_num && palindrome / j <= max_num) {
                return palindrome % 1337;
            }
        }
    }

    return 0;
}