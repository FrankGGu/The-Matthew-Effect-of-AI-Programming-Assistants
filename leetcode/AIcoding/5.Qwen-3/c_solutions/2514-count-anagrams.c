#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long factorial(int n) {
    long long result = 1;
    for (int i = 2; i <= n; i++) {
        result *= i;
    }
    return result;
}

long long combination(int n, int k) {
    if (k > n || k < 0) return 0;
    if (k == 0 || k == n) return 1;
    k = (k > n - k) ? n - k : k;
    long long result = 1;
    for (int i = 0; i < k; i++) {
        result = result * (n - i) / (i + 1);
    }
    return result;
}

long long countAnagrams(char* s) {
    int len = strlen(s);
    int freq[26] = {0};
    for (int i = 0; i < len; i++) {
        freq[s[i] - 'a']++;
    }

    long long total = factorial(len);
    for (int i = 0; i < 26; i++) {
        if (freq[i] > 1) {
            total /= factorial(freq[i]);
        }
    }

    return total;
}