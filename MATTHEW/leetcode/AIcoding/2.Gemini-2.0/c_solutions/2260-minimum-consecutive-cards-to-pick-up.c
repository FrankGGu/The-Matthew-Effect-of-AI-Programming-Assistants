#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumCardPickup(int* cards, int cardsSize) {
    int min_len = INT_MAX;
    int hash[100001] = {0};
    int start = 0;

    for (int end = 0; end < cardsSize; end++) {
        hash[cards[end]]++;

        while (hash[cards[end]] > 1) {
            int len = end - start + 1;
            if (len < min_len) {
                min_len = len;
            }
            hash[cards[start]]--;
            start++;
        }
    }

    if (min_len == INT_MAX) {
        return -1;
    } else {
        return min_len;
    }
}