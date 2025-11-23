int maxVowels(char* s, int k) {
    int max_vowels = 0;
    int current_vowels = 0;

    for (int i = 0; i < k; i++) {
        if (s[i] == 'a' || s[i] == 'e' || s[i] == 'i' || s[i] == 'o' || s[i] == 'u') {
            current_vowels++;
        }
    }

    max_vowels = current_vowels;

    for (int i = k; s[i] != '\0'; i++) {
        if (s[i - k] == 'a' || s[i - k] == 'e' || s[i - k] == 'i' || s[i - k] == 'o' || s[i - k] == 'u') {
            current_vowels--;
        }
        if (s[i] == 'a' || s[i] == 'e' || s[i] == 'i' || s[i] == 'o' || s[i] == 'u') {
            current_vowels++;
        }
        if (current_vowels > max_vowels) {
            max_vowels = current_vowels;
        }
    }

    return max_vowels;
}