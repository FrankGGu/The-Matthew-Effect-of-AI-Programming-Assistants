int minimumCost(char *s) {
    int count[26] = {0};
    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        count[s[i] - 'a']++;
    }
    int minCost = n;
    for (int i = 0; i < 26; i++) {
        if (count[i] > 0) {
            int cost = n - count[i];
            minCost = (cost < minCost) ? cost : minCost;
        }
    }
    return minCost;
}