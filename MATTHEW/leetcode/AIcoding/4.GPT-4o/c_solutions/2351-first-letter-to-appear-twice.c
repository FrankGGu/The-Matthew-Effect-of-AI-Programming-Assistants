char repeatedCharacter(char * s){
    int seen[26] = {0};
    for (int i = 0; s[i] != '\0'; i++) {
        if (seen[s[i] - 'a'] == 1) {
            return s[i];
        }
        seen[s[i] - 'a'] = 1;
    }
    return '\0';
}