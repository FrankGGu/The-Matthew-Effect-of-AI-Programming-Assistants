#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int gcd(int a, int b) {
    if (b == 0) {
        return a;
    }
    return gcd(b, a % b);
}

bool hasGroupsSizeX(int* deck, int deckSize) {
    if (deckSize < 2) {
        return false;
    }

    int counts[10000] = {0};
    for (int i = 0; i < deckSize; i++) {
        counts[deck[i]]++;
    }

    int g = 0;
    for (int i = 0; i < 10000; i++) {
        if (counts[i] > 0) {
            if (g == 0) {
                g = counts[i];
            } else {
                g = gcd(g, counts[i]);
            }
        }
    }

    return g >= 2;
}