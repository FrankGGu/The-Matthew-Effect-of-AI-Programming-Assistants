#include <stdbool.h>

int findChampion(int n, int** battles, int battlesSize, int* battlesColSize) {
    bool isDefeated[n];

    for (int i = 0; i < n; i++) {
        isDefeated[i] = false;
    }

    for (int i = 0; i < battlesSize; i++) {
        int loser = battles[i][1];
        isDefeated[loser] = true;
    }

    int championCount = 0;
    int championIndex = -1;

    for (int i = 0; i < n; i++) {
        if (!isDefeated[i]) {
            championCount++;
            championIndex = i;
        }
    }

    if (championCount == 1) {
        return championIndex;
    } else {
        return -1;
    }
}