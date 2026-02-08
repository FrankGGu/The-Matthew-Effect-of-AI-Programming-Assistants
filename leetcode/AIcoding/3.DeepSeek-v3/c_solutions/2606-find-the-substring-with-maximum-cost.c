int maximumCostSubstring(char * s, char * chars, int* vals, int valsSize){
    int charToVal[26] = {0};
    for (int i = 0; i < 26; i++) {
        charToVal[i] = i + 1;
    }

    for (int i = 0; i < valsSize; i++) {
        charToVal[chars[i] - 'a'] = vals[i];
    }

    int maxCost = 0;
    int currentCost = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        int val = charToVal[s[i] - 'a'];
        currentCost = currentCost + val > val ? currentCost + val : val;
        maxCost = maxCost > currentCost ? maxCost : currentCost;
    }

    return maxCost > 0 ? maxCost : 0;
}