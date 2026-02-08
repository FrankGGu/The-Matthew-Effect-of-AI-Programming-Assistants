#include <string.h>

#define MOD 1000000007

long long count1(char c) {
    if (c == '0') {
        return 0;
    } else if (c == '*') {
        return 9;
    } else { // '1' - '9'
        return 1;
    }
}

long long count2(char c1, char c2) {
    if (c1 == '0') {
        return 0;
    }
    if (c1 == '1') {
        if (c2 == '*') {
            return 9; // 11-19
        } else { // '0'-'9'
            return 1; // 10-19
        }
    }
    if (c1 == '2') {
        if (c2 == '*') {
            return 6; // 21-26
        } else if (c2 >= '0' && c2 <= '6') {
            return 1; // 20-26
        } else { // '7'-'9'
            return 0;
        }
    }
    if (c1 == '*') {
        if (c2 == '*') {
            return 15; // count2('1', '*') + count2('2', '*') = 9 + 6
        } else if (c2 >= '0' && c2 <= '6') {
            return 2; // count2('1', c2) + count2('2', c2) = 1 + 1
        } else { // '7'-'9'
            return 1; // count2('1', c2) = 1
        }
    }
    return 0; // '3'-'9'
}

int numDecodings(char* s) {
    int n = strlen(s);

    // dp[i-2]
    long long prev2 = 1; 
    // dp[i-1]
    long long prev1 = count1(s[0]); 

    for (int i = 2; i <= n; i++) {
        long long current = 0;
        char current_char = s[i-1];
        char prev_char = s[i-2];

        // Ways to decode current_char alone
        current = (prev1 * count1(current_char)) % MOD;

        // Ways to decode prev_char and current_char as a pair
        current = (current + prev2 * count2(prev_char, current_char)) % MOD;

        prev2 = prev1;
        prev1 = current;
    }

    return (int)prev1;
}