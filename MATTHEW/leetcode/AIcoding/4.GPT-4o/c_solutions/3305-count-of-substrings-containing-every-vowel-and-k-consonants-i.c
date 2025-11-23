int count_vowels_and_consonants(char *s, int *vowel_count, int *consonant_count) {
    int vowels = 0, consonants = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        char ch = s[i];
        if (ch >= 'A' && ch <= 'Z') ch += 32; // Convert to lowercase
        if (ch == 'a' || ch == 'e' || ch == 'i' || ch == 'o' || ch == 'u') {
            vowels++;
        } else if (ch >= 'b' && ch <= 'z') {
            consonants++;
        }
    }
    *vowel_count = vowels;
    *consonant_count = consonants;
    return vowels >= 5 ? 1 : 0;
}

int count_of_substrings(char *s, int k) {
    int n = strlen(s), count = 0;
    for (int start = 0; start < n; start++) {
        int vowel_count = 0, consonant_count = 0;
        for (int end = start; end < n; end++) {
            if (count_vowels_and_consonants(s + start, &vowel_count, &consonant_count)) {
                if (consonant_count >= k) {
                    count++;
                }
            }
        }
    }
    return count;
}

int getCount(char *s, int k) {
    return count_of_substrings(s, k);
}