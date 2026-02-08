#include <stdlib.h>
#include <string.h>

int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int maxGroups(int* cards, int cardsSize) {
    qsort(cards, cardsSize, sizeof(int), cmp);

    int res = 0;
    int i = 0;
    while (i < cardsSize) {
        int count = 1;
        while (i + 1 < cardsSize && count < cards[i]) {
            count++;
            i++;
        }
        if (count >= cards[i]) {
            res++;
        }
        i++;
    }
    return res;
}