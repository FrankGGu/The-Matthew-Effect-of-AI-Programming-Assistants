#include <stdbool.h>
#include <string.h> // For memset

int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

bool hasGroupsSizeX(int* deck, int deckSize) {
    if (deckSize < 2) {
        return false;
    }

    int counts[10000] = {0}; // Card values are 0 to 9999

    // Count frequencies of each card
    for (int i = 0; i < deckSize; i++) {
        counts[deck[i]]++;
    }

    int result_gcd = 0;

    // Find the GCD of all positive frequencies
    for (int i = 0; i < 10000; i++) {
        if (counts[i] > 0) {
            if (result_gcd == 0) {
                result_gcd = counts[i];
            } else {
                result_gcd = gcd(result_gcd, counts[i]);
            }
        }
    }

    // If the GCD is 1, it's not possible to form groups of size X >= 2
    // If the GCD is 0, it means the deck was empty, which is handled by deckSize < 2
    // Or if all counts were 0, result_gcd would remain 0. But deckSize < 2 handles empty deck.
    // So result_gcd will be at least 1 if deckSize >= 1.
    return result_gcd >= 2;
}