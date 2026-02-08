int countOfSubstrings(char* word, int k) {
    int n = strlen(word);
    int count = 0;

    for (int i = 0; i < n; i++) {
        int vowels = 0;
        int consonants = 0;
        int a = 0, e = 0, i_vowel = 0, o = 0, u = 0;

        for (int j = i; j < n; j++) {
            char c = word[j];
            if (c == 'a') {
                if (a == 0) vowels++;
                a++;
            } else if (c == 'e') {
                if (e == 0) vowels++;
                e++;
            } else if (c == 'i') {
                if (i_vowel == 0) vowels++;
                i_vowel++;
            } else if (c == 'o') {
                if (o == 0) vowels++;
                o++;
            } else if (c == 'u') {
                if (u == 0) vowels++;
                u++;
            } else {
                consonants++;
            }

            if (vowels == 5 && consonants == k) {
                count++;
            }

            if (consonants > k) {
                break;
            }
        }
    }

    return count;
}