char* answerString(char* word, int k) {
    int n = strlen(word);
    char* result = (char*)malloc((n + 1) * sizeof(char));
    strcpy(result, word);

    for (int i = 0; i < n; i++) {
        if (k <= 0) break;

        char maxChar = result[i];
        int maxIndex = i;

        for (int j = i + 1; j < n && j <= i + k; j++) {
            if (result[j] > maxChar) {
                maxChar = result[j];
                maxIndex = j;
            }
        }

        if (maxIndex != i) {
            for (int j = maxIndex; j > i; j--) {
                char temp = result[j];
                result[j] = result[j - 1];
                result[j - 1] = temp;
            }
            k -= (maxIndex - i);
        }
    }

    return result;
}