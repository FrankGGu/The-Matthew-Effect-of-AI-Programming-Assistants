#include <stdbool.h>
#include <stdlib.h>

int gcd(int a, int b) {
    while (b) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

bool hasGroupsSizeX(int* deck, int deckSize) {
    int count[10000] = {0};
    for (int i = 0; i < deckSize; i++) {
        count[deck[i]]++;
    }

    int g = 0;
    for (int i = 0; i < 10000; i++) {
        if (count[i] > 0) {
            g = gcd(g, count[i]);
        }
    }

    return g >= 2;
}