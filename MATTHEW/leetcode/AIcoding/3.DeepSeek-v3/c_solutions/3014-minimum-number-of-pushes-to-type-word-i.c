int minimumPushes(char* word) {
    int count[26] = {0};
    int len = strlen(word);

    for (int i = 0; i < len; i++) {
        count[word[i] - 'a']++;
    }

    for (int i = 0; i < 25; i++) {
        for (int j = i + 1; j < 26; j++) {
            if (count[i] < count[j]) {
                int temp = count[i];
                count[i] = count[j];
                count[j] = temp;
            }
        }
    }

    int pushes = 0;
    for (int i = 0; i < 26; i++) {
        if (count[i] > 0) {
            pushes += count[i] * ((i / 8) + 1);
        }
    }

    return pushes;
}