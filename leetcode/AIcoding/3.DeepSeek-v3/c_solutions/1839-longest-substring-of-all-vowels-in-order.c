int longestBeautifulSubstring(char* word) {
    int max_len = 0;
    int len = strlen(word);
    int i = 0;

    while (i < len) {
        if (word[i] == 'a') {
            int start = i;
            while (i < len && word[i] == 'a') i++;

            if (i < len && word[i] == 'e') {
                while (i < len && word[i] == 'e') i++;

                if (i < len && word[i] == 'i') {
                    while (i < len && word[i] == 'i') i++;

                    if (i < len && word[i] == 'o') {
                        while (i < len && word[i] == 'o') i++;

                        if (i < len && word[i] == 'u') {
                            while (i < len && word[i] == 'u') i++;
                            max_len = fmax(max_len, i - start);
                        } else {
                            i++;
                        }
                    } else {
                        i++;
                    }
                } else {
                    i++;
                }
            } else {
                i++;
            }
        } else {
            i++;
        }
    }

    return max_len;
}