bool checkStrings(char* s1, char* s2) {
    int count1[26] = {0};
    int count2[26] = {0};
    int n = strlen(s1);

    for (int i = 0; i < n; i++) {
        if (i % 2 == 0) {
            count1[s1[i] - 'a']++;
            count1[s2[i] - 'a']--;
        } else {
            count2[s1[i] - 'a']++;
            count2[s2[i] - 'a']--;
        }
    }

    for (int i = 0; i < 26; i++) {
        if (count1[i] != 0 || count2[i] != 0) {
            return false;
        }
    }

    return true;
}