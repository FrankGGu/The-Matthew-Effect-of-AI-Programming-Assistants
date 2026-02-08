#include <limits.h>
#include <string.h>

int minimumCardPickup(int* cards, int cardsSize) {
    int last_seen[1000001]; 
    memset(last_seen, -1, sizeof(last_seen));

    int min_len = INT_MAX;

    for (int i = 0; i < cardsSize; i++) {
        int current_card = cards[i];
        if (last_seen[current_card] != -1) {
            int current_len = i - last_seen[current_card] + 1;
            if (current_len < min_len) {
                min_len = current_len;
            }
            if (min_len == 2) {
                return 2;
            }
        }
        last_seen[current_card] = i;
    }

    if (min_len == INT_MAX) {
        return -1;
    } else {
        return min_len;
    }
}