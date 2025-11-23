bool isVowel(char c) {
    return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' ||
           c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U';
}

bool halvesAreAlike(char* s) {
    int len = strlen(s);
    int half = len / 2;
    int count1 = 0, count2 = 0;

    for (int i = 0; i < half; i++) {
        if (isVowel(s[i])) count1++;
        if (isVowel(s[i + half])) count2++;
    }

    return count1 == count2;
}