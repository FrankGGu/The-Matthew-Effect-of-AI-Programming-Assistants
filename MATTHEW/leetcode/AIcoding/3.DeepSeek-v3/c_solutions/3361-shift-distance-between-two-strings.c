int shiftDistance(char* s, char* t, int nextCost, int previousCost) {
    int totalCost = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        int diff = s[i] - t[i];
        if (diff == 0) continue;

        int forwardCost, backwardCost;
        if (diff > 0) {
            forwardCost = (26 - diff) * nextCost;
            backwardCost = diff * previousCost;
        } else {
            diff = -diff;
            forwardCost = diff * nextCost;
            backwardCost = (26 - diff) * previousCost;
        }

        totalCost += (forwardCost < backwardCost) ? forwardCost : backwardCost;
    }
    return totalCost;
}