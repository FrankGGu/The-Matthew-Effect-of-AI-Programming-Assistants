int countVowels(char * word) {
    int n = strlen(word);
    long long totalVowels = 0;
    long long mod = 1000000007;

    for (int i = 0; i < n; i++) {
        if (word[i] == 'a' || word[i] == 'e' || word[i] == 'i' || word[i] == 'o' || word[i] == 'u') {
            totalVowels = (totalVowels + (i + 1) * (n - i)) % mod;
        }
    }

    return (int)totalVowels;
}