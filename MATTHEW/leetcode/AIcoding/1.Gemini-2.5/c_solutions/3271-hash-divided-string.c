#include <string.h>
#include <stdbool.h>

bool hashDividedString(char * s, int k) {
    int n = strlen(s);

    if (k <= 0) {
        return false;
    }

    if (n % k != 0) {
        return false;
    }

    int sub_len = n / k;

    if (sub_len == 0) {
        return false;
    }

    long long p = 31; 
    long long m = 1e9 + 7; 

    long long first_sub_hash = 0;
    long long p_pow = 1;
    for (int i = sub_len - 1; i >= 0; i--) {
        first_sub_hash = (first_sub_hash + (s[i] - 'a' + 1) * p_pow) % m;
        p_pow = (p_pow * p) % m;
    }

    for (int i = 1; i < k; i++) {
        long long current_sub_hash = 0;
        p_pow = 1; 
        for (int j = sub_len - 1; j >= 0; j--) {
            current_sub_hash = (current_sub_hash + (s[i * sub_len + j] - 'a' + 1) * p_pow) % m;
            p_pow = (p_pow * p) % m;
        }
        if (current_sub_hash != first_sub_hash) {
            return false;
        }
    }

    return true;
}