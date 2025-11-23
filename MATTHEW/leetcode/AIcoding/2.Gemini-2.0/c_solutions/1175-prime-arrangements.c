#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numPrimeArrangements(int n){
    int prime_count = 0;
    bool is_prime[101] = {false};

    for (int i = 2; i <= n; i++) {
        bool prime = true;
        for (int j = 2; j * j <= i; j++) {
            if (i % j == 0) {
                prime = false;
                break;
            }
        }
        if (prime) {
            prime_count++;
            is_prime[i] = true;
        }
    }

    long long ans = 1;
    long long mod = 1000000007;

    for (int i = 1; i <= prime_count; i++) {
        ans = (ans * i) % mod;
    }

    for (int i = 1; i <= (n - prime_count); i++) {
        ans = (ans * i) % mod;
    }

    return (int)ans;
}