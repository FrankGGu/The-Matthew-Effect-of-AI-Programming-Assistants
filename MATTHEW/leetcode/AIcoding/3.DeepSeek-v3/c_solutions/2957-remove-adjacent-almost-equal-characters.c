int removeAlmostEqualCharacters(char* word) {
    int n = strlen(word);
    int count = 0;
    for (int i = 1; i < n; i++) {
        if (abs(word[i] - word[i-1]) <= 1) {
            count++;
            i++;
        }
    }
    return count;
}