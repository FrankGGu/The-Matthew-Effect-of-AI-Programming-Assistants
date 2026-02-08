#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool winnerOfGame(char * colors) {
    int a = 0;
    int b = 0;
    int n = 0;
    while (colors[n] != '\0') {
        n++;
    }

    for (int i = 1; i < n - 1; i++) {
        if (colors[i - 1] == colors[i] && colors[i] == colors[i + 1]) {
            if (colors[i] == 'A') {
                a++;
            } else {
                b++;
            }
        }
    }

    return a > b;
}