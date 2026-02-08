char * sortString(char * s){
    int freq[26] = {0};
    int len = strlen(s);

    for(int i = 0; i < len; i++) {
        freq[s[i] - 'a']++;
    }

    char *result = (char *)malloc((len + 1) * sizeof(char));
    int idx = 0;

    while(idx < len) {
        for(int i = 0; i < 26; i++) {
            if(freq[i] > 0) {
                result[idx++] = 'a' + i;
                freq[i]--;
            }
        }

        for(int i = 25; i >= 0; i--) {
            if(freq[i] > 0) {
                result[idx++] = 'a' + i;
                freq[i]--;
            }
        }
    }

    result[len] = '\0';
    return result;
}