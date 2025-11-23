char* repeatLimitedString(char* s, int repeatLimit) {
    int freq[26] = {0};
    int len = strlen(s);
    for (int i = 0; i < len; i++) {
        freq[s[i] - 'a']++;
    }

    char* result = (char*)malloc((len + 1) * sizeof(char));
    int idx = 0;

    for (int i = 25; i >= 0; i--) {
        if (freq[i] == 0) continue;

        int count = 0;
        while (freq[i] > 0) {
            if (count < repeatLimit) {
                result[idx++] = 'a' + i;
                freq[i]--;
                count++;
            } else {
                int found = 0;
                for (int j = i - 1; j >= 0; j--) {
                    if (freq[j] > 0) {
                        result[idx++] = 'a' + j;
                        freq[j]--;
                        count = 0;
                        found = 1;
                        break;
                    }
                }
                if (!found) break;
            }
        }
    }

    result[idx] = '\0';
    return result;
}