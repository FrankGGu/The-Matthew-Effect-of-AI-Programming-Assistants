#define MAXN 100000

int maximumBeauty(int* flowers, int flowersSize, int newFlowers) {
    int count[MAXN + 1] = {0};
    int maxBeauty = 0;

    for (int i = 0; i < flowersSize; i++) {
        count[flowers[i]]++;
    }

    for (int i = 1; i <= MAXN; i++) {
        if (count[i] == 0) {
            int needed = 0;
            for (int j = 1; j <= i; j++) {
                needed += count[j] ? 0 : 1;
            }
            if (needed <= newFlowers) {
                maxBeauty = i;
            }
        }
    }

    return maxBeauty;
}