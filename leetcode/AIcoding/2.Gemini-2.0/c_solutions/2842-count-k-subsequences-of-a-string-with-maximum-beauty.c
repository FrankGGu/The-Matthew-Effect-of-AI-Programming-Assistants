#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

long long power(long long base, long long exp) {
    long long res = 1;
    base %= MOD;
    while (exp > 0) {
        if (exp % 2 == 1) res = (res * base) % MOD;
        base = (base * base) % MOD;
        exp /= 2;
    }
    return res;
}

long long solve() {
    char s[100001];
    int k;
    scanf("%s %d", s, &k);

    int counts[26] = {0};
    for (int i = 0; s[i] != '\0'; i++) {
        counts[s[i] - 'a']++;
    }

    int num_non_zero = 0;
    for (int i = 0; i < 26; i++) {
        if (counts[i] > 0) {
            num_non_zero++;
        }
    }

    if (k > num_non_zero) {
        return 0;
    }

    long long ans = 1;
    int min_count = 100001;
    for (int i = 0; i < 26; i++) {
        if (counts[i] > 0) {
            if (counts[i] < min_count) {
                min_count = counts[i];
            }
        }
    }

    int num_min_count = 0;
    for (int i = 0; i < 26; i++) {
        if (counts[i] == min_count) {
            num_min_count++;
        }
    }

    if (k <= num_min_count) {
        long long n = num_min_count;
        long long r = k;
        long long numerator = 1;
        for (long long i = 0; i < r; i++) {
            numerator = (numerator * (n - i)) % MOD;
        }

        long long denominator = 1;
        for (long long i = 1; i <= r; i++) {
            denominator = (denominator * i) % MOD;
        }

        long long inv_denominator = power(denominator, MOD - 2);
        ans = (numerator * inv_denominator) % MOD;

        long long beauty = power(min_count, k);
        return (ans * beauty) % MOD;
    } else {
        long long beauty = 1;
        for (int i = 0; i < 26; i++) {
            if (counts[i] > 0 && counts[i] <= min_count)
            {
                beauty = (beauty * power(counts[i], 1)) % MOD;
            } else if (counts[i] > 0) {
                beauty = (beauty * power(min_count,1)) % MOD;
            }
        }

        long long n = num_min_count;
        long long r = num_min_count;
        long long numerator = 1;
        for (long long i = 0; i < r; i++) {
            numerator = (numerator * (n - i)) % MOD;
        }

        long long denominator = 1;
        for (long long i = 1; i <= r; i++) {
            denominator = (denominator * i) % MOD;
        }

        long long inv_denominator = power(denominator, MOD - 2);
        ans = (numerator * inv_denominator) % MOD;

        long long rem = k - num_min_count;
        int remaining = 0;
        for (int i = 0; i < 26; i++) {
            if (counts[i] > min_count) {
                remaining++;
            }
        }

        n = remaining;
        r = rem;

        if(n==0) return 0;

        numerator = 1;
        for (long long i = 0; i < r; i++) {
            numerator = (numerator * (n - i)) % MOD;
        }

        denominator = 1;
        for (long long i = 1; i <= r; i++) {
            denominator = (denominator * i) % MOD;
        }

        inv_denominator = power(denominator, MOD - 2);
        ans = (ans * (numerator * inv_denominator) % MOD) %MOD;

        return (ans * beauty) % MOD;
    }
}