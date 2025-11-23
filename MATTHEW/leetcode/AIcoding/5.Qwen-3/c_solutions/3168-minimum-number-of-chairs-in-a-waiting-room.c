#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minWaitingRooms(char* s) {
    int currentChairs = 0;
    int maxChairs = 0;
    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        if (s[i] == 'E') {
            currentChairs++;
            if (currentChairs > maxChairs) {
                maxChairs = currentChairs;
            }
        } else if (s[i] == 'L') {
            currentChairs--;
        }
    }
    return maxChairs;
}