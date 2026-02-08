#include <string.h>
#include <stdlib.h>
#include <stdio.h>

int min(int a, int b) {
    return a < b ? a : b;
}

int minOperations(char * s) {
    int n = strlen(s);
    int count0 = 0; // Cost to make it start with '0' (e.g., "010101...")
    int count1 = 0; // Cost to make it start with '1' (e.g., "101010...")

    for (int i = 0; i < n; i++) {
        if (i % 2 == 0) { // Even index
            if (s[i] == '0') {
                count1++; // If target is '1', this '0' needs to change
            } else { // s[i] == '1'
                count0++; // If target is '0', this '1' needs to change
            }
        } else { // Odd index
            if (s[i] == '0') {
                count0++; // If target is '1', this '0' needs to change
            } else { // s[i] == '1'
                count1++; // If target is '0', this '1' needs to change
            }
        }
    }
    return min(count0, count1);
}