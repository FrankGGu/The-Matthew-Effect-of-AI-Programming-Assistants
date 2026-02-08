int findPermutationDifference(char* s, char* t) {
    int pos_s[26] = {0};
    int pos_t[26] = {0};

    for (int i = 0; s[i]; i++) {
        pos_s[s[i] - 'a'] = i;
    }

    for (int i = 0; t[i]; i++) {
        pos_t[t[i] - 'a'] = i;
    }

    int diff = 0;
    for (int i = 0; i < 26; i++) {
        diff += abs(pos_s[i] - pos_t[i]);
    }

    return diff;
}