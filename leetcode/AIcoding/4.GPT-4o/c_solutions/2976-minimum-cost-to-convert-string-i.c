int minimumCost(char * s, char * t, int cost) {
    int n = strlen(s);
    int totalCost = 0;
    for (int i = 0; i < n; i++) {
        if (s[i] != t[i]) {
            totalCost += cost;
        }
    }
    return totalCost;
}