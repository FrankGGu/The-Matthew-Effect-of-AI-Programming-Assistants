bool isAnagram(char * s, char * t){
    int count[26] = {0};
    while (*s) {
        count[*s - 'a']++;
        s++;
    }
    while (*t) {
        count[*t - 'a']--;
        t++;
    }
    for (int i = 0; i < 26; i++) {
        if (count[i] != 0) {
            return false;
        }
    }
    return true;
}