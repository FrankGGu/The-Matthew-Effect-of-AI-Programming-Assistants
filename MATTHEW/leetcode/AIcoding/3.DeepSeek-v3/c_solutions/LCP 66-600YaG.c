int minBooths(char** demand, int demandSize) {
    int maxCount[26] = {0};
    for (int i = 0; i < demandSize; i++) {
        int count[26] = {0};
        char* s = demand[i];
        for (int j = 0; s[j] != '\0'; j++) {
            count[s[j] - 'a']++;
        }
        for (int j = 0; j < 26; j++) {
            if (count[j] > maxCount[j]) {
                maxCount[j] = count[j];
            }
        }
    }

    int total = 0;
    for (int i = 0; i < 26; i++) {
        total += maxCount[i];
    }
    return total;
}