int minUnfairness;

void backtrack(int* cookies, int cookiesSize, int k, int* distribution, int index) {
    if (index == cookiesSize) {
        int currentMax = 0;
        for (int i = 0; i < k; i++) {
            if (distribution[i] > currentMax) {
                currentMax = distribution[i];
            }
        }
        if (currentMax < minUnfairness) {
            minUnfairness = currentMax;
        }
        return;
    }

    for (int i = 0; i < k; i++) {
        distribution[i] += cookies[index];
        if (distribution[i] < minUnfairness) {
            backtrack(cookies, cookiesSize, k, distribution, index + 1);
        }
        distribution[i] -= cookies[index];
    }
}

int distributeCookies(int* cookies, int cookiesSize, int k) {
    minUnfairness = INT_MAX;
    int* distribution = (int*)calloc(k, sizeof(int));
    backtrack(cookies, cookiesSize, k, distribution, 0);
    free(distribution);
    return minUnfairness;
}