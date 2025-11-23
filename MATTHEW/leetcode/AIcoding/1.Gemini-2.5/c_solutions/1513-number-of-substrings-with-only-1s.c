#include <string.h>

int numSub(char * s){
    long long totalSubstrings = 0;
    long long currentConsecutiveOnes = 0;
    long long MOD = 1000000007;

    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == '1') {
            currentConsecutiveOnes++;
        } else {
            currentConsecutiveOnes = 0;
        }
        totalSubstrings = (totalSubstrings + currentConsecutiveOnes) % MOD;
    }

    return (int)totalSubstrings;
}