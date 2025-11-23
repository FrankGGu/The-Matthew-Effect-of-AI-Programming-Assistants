#include <stdbool.h>
#include <math.h>

bool is_palindrome(long long n) {
    long long reversed = 0, original = n;
    while (n > 0) {
        reversed = reversed * 10 + n % 10;
        n /= 10;
    }
    return original == reversed;
}

int superPalindromesInRange(char* left, char* right) {
    long long l = atoll(left), r = atoll(right);
    int count = 0;

    for (long long i = 1; i * i <= r; i++) {
        if (is_palindrome(i)) {
            long long palin = i * i;
            if (palin >= l && palin <= r) {
                count++;
            }
        }
    }

    return count;
}