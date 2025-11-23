#include <stdbool.h>
#include <string.h> // For memset

#define MAX_CARD_TYPE 100000

int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

bool hasGroupsSizeX(int* deck, int deckSize) {
    if (deckSize == 0) {
        return false;
    }

    int counts[MAX_CARD_TYPE];
    memset(counts, 0, sizeof(counts));

    for (int i = 0; i < deckSize; i++) {
        counts[deck[i]]++;
    }

    int result_gcd = 0;
    for (int i = 0; i < MAX_CARD_TYPE; i++) {
        if (counts[i] > 0) {
            if (result_gcd == 0) {
                result_gcd = counts[i];
            } else {
                result_gcd = gcd(result_gcd, counts[i]);
            }
        }
    }

    return result_gcd >= 2;
}