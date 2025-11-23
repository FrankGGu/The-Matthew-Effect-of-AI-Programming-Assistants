bool isValid(char* word) {
    int len = strlen(word);
    if (len < 3) return false;

    int vowels = 0, consonants = 0;
    bool has_vowel = false, has_consonant = false;

    for (int i = 0; i < len; i++) {
        char c = word[i];
        if (!isalnum(c)) return false;

        if (isalpha(c)) {
            char lower = tolower(c);
            if (lower == 'a' || lower == 'e' || lower == 'i' || lower == 'o' || lower == 'u') {
                has_vowel = true;
            } else {
                has_consonant = true;
            }
        }
    }

    return has_vowel && has_consonant;
}