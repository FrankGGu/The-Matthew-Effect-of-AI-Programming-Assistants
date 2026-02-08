#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

typedef long long ll;

char* findSubstring(char* s, int power) {
    int n = strlen(s);
    ll hash = 0;
    ll base = 26;
    ll power_val = 1;
    for (int i = 0; i < power; ++i) {
        power_val = (power_val * base) % MOD;
    }
    for (int i = 0; i < power; ++i) {
        hash = (hash * base + s[i]) % MOD;
    }
    if (hash == 0) {
        char* result = (char*)malloc((power + 1) * sizeof(char));
        strncpy(result, s, power);
        result[power] = '\0';
        return result;
    }
    for (int i = power; i < n; ++i) {
        hash = (hash - (s[i - power] * power_val) % MOD + MOD) % MOD;
        hash = (hash * base + s[i]) % MOD;
        if (hash == 0) {
            char* result = (char*)malloc((power + 1) * sizeof(char));
            strncpy(result, s + i - power + 1, power);
            result[power] = '\0';
            return result;
        }
    }
    char* result = (char*)malloc(2 * sizeof(char));
    result[0] = '\0';
    return result;
}