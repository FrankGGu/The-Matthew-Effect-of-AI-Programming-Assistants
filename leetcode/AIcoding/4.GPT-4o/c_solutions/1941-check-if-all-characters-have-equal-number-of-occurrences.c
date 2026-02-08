bool areOccurrencesEqual(char * s){
    int count[26] = {0};
    int i = 0, num = 0;

    while (s[i]) {
        count[s[i] - 'a']++;
        i++;
    }

    for (i = 0; i < 26; i++) {
        if (count[i] > 0) {
            if (num == 0) num = count[i];
            else if (count[i] != num) return false;
        }
    }
    return true;
}