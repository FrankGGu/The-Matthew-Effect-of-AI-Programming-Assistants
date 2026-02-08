long long countVowels(char * word) {
    long long total = 0;
    int n = strlen(word);

    for (int i = 0; i < n; i++) {
        char c = word[i];
        if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
            total += (long long)(i + 1) * (n - i);
        }
    }

    return total;
}