#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minStands(char **demand, int demandSize) {
    int count[26] = {0};
    for (int i = 0; i < demandSize; i++) {
        int freq[26] = {0};
        for (int j = 0; demand[i][j] != '\0'; j++) {
            freq[demand[i][j] - 'a']++;
        }
        for (int k = 0; k < 26; k++) {
            if (freq[k] > 0) {
                count[k] = (count[k] > freq[k] ? count[k] : freq[k]);
            }
        }
    }

    int sum = 0;
    for (int i = 0; i < 26; i++) {
        sum += count[i];
    }
    return sum;
}