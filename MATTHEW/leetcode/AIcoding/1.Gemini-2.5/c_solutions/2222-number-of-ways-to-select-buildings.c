#include <string.h>

long long numberOfWays(char * s){
    long long totalZeros = 0;
    long long totalOnes = 0;
    int n = strlen(s);

    for (int i = 0; i < n; i++) {
        if (s[i] == '0') {
            totalZeros++;
        } else {
            totalOnes++;
        }
    }

    long long ans = 0;
    long long leftZeros = 0;
    long long leftOnes = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] == '0') {
            // If the current building is '0', it can be the middle of a "101" sequence.
            // We need to count '1's to its left and '1's to its right.
            // '1's to the left are accumulated in leftOnes.
            // '1's to the right are totalOnes - leftOnes (since current '0' doesn't affect '1' counts).
            ans += leftOnes * (totalOnes - leftOnes);
            leftZeros++; // Update count of '0's seen so far for future iterations.
        } else { // s[i] == '1'
            // If the current building is '1', it can be the middle of a "010" sequence.
            // We need to count '0's to its left and '0's to its right.
            // '0's to the left are accumulated in leftZeros.
            // '0's to the right are totalZeros - leftZeros (since current '1' doesn't affect '0' counts).
            ans += leftZeros * (totalZeros - leftZeros);
            leftOnes++; // Update count of '1's seen so far for future iterations.
        }
    }
    return ans;
}