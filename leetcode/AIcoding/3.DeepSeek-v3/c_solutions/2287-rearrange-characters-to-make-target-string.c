int rearrangeCharacters(char* s, char* target) {
    int sCount[26] = {0};
    int targetCount[26] = {0};

    for (int i = 0; s[i]; i++) {
        sCount[s[i] - 'a']++;
    }

    for (int i = 0; target[i]; i++) {
        targetCount[target[i] - 'a']++;
    }

    int minCopies = INT_MAX;
    for (int i = 0; i < 26; i++) {
        if (targetCount[i] > 0) {
            int copies = sCount[i] / targetCount[i];
            if (copies < minCopies) {
                minCopies = copies;
            }
        }
    }

    return minCopies;
}