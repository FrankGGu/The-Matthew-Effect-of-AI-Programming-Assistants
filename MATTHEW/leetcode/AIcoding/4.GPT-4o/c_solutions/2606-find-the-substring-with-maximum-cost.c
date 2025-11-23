int maximumCostSubstring(char *s, int k) {
    int n = strlen(s);
    int maxCost = 0, currentCost = 0;

    for (int i = 0; i < n; i++) {
        int cost = s[i] - 'a' + 1 - k;
        currentCost += cost;
        if (currentCost < 0) {
            currentCost = 0;
        }
        if (currentCost > maxCost) {
            maxCost = currentCost;
        }
    }

    return maxCost;
}