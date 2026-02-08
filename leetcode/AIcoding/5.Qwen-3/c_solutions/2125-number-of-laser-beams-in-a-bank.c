#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfLaserBeams(char** bank, int bankSize) {
    int prev = 0;
    int count = 0;
    for (int i = 0; i < bankSize; i++) {
        int curr = 0;
        for (int j = 0; j < strlen(bank[i]); j++) {
            if (bank[i][j] == '1') {
                curr++;
            }
        }
        if (curr > 0) {
            count += prev * curr;
            prev = curr;
        }
    }
    return count;
}