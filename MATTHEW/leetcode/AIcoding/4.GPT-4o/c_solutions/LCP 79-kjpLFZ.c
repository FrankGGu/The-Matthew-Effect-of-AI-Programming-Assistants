char* extractSpell(char* spell, char* words[], int wordsSize) {
    int spellCount[26] = {0};
    for (int i = 0; spell[i] != '\0'; i++) {
        spellCount[spell[i] - 'a']++;
    }

    for (int i = 0; i < wordsSize; i++) {
        int wordCount[26] = {0};
        for (int j = 0; words[i][j] != '\0'; j++) {
            wordCount[words[i][j] - 'a']++;
        }

        int canForm = 1;
        for (int k = 0; k < 26; k++) {
            if (wordCount[k] > spellCount[k]) {
                canForm = 0;
                break;
            }
        }

        if (canForm) {
            return words[i];
        }
    }

    return "";
}