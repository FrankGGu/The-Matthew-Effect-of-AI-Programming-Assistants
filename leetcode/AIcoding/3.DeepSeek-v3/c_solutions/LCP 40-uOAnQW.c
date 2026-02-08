int cmp(const void* a, const void* b) {
    return *(int*)b - *(int*)a;
}

int maxmiumScore(int* cards, int cardsSize, int cnt) {
    qsort(cards, cardsSize, sizeof(int), cmp);

    int sum = 0;
    int last_odd = -1, last_even = -1;

    for (int i = 0; i < cnt; i++) {
        sum += cards[i];
        if (cards[i] % 2 == 0) {
            last_even = cards[i];
        } else {
            last_odd = cards[i];
        }
    }

    if (sum % 2 == 0) {
        return sum;
    }

    int ans = 0;
    for (int i = cnt; i < cardsSize; i++) {
        if (cards[i] % 2 == 0 && last_odd != -1) {
            ans = fmax(ans, sum - last_odd + cards[i]);
        } else if (cards[i] % 2 == 1 && last_even != -1) {
            ans = fmax(ans, sum - last_even + cards[i]);
        }
    }

    return ans;
}