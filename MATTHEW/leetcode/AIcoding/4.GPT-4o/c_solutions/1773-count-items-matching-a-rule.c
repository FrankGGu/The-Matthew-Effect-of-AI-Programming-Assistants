int countMatches(char ***items, int itemsSize, char *ruleKey, char *ruleValue) {
    int count = 0;
    int ruleIndex = (ruleKey[0] == 't') ? 0 : (ruleKey[0] == 'c') ? 1 : 2;

    for (int i = 0; i < itemsSize; i++) {
        if (strcmp(items[i][ruleIndex], ruleValue) == 0) {
            count++;
        }
    }
    return count;
}