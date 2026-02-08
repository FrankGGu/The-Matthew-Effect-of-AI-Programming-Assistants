#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numJewelsInNecklace(char* jewels, char* stones) {
    int count = 0;
    int jewelSet[58] = {0}; // ASCII for 'A' to 'z' is 65 to 122, 58 covers up to 'Z'

    for (int i = 0; jewels[i] != '\0'; i++) {
        jewelSet[jewels[i] - 'A'] = 1;
    }

    for (int i = 0; stones[i] != '\0'; i++) {
        if (jewelSet[stones[i] - 'A'] == 1) {
            count++;
        }
    }

    return count;
}