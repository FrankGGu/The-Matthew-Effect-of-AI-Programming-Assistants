int expressiveWords(char* s, char** words, int wordsSize) {
    int s_len = strlen(s);
    int count = 0;

    for (int i = 0; i < wordsSize; i++) {
        char* word = words[i];
        int word_len = strlen(word);
        int s_ptr = 0, word_ptr = 0;
        int valid = 1;

        while (s_ptr < s_len && word_ptr < word_len) {
            if (s[s_ptr] != word[word_ptr]) {
                valid = 0;
                break;
            }

            int s_count = 1;
            while (s_ptr + 1 < s_len && s[s_ptr] == s[s_ptr + 1]) {
                s_count++;
                s_ptr++;
            }

            int word_count = 1;
            while (word_ptr + 1 < word_len && word[word_ptr] == word[word_ptr + 1]) {
                word_count++;
                word_ptr++;
            }

            if (s_count < word_count || (s_count > word_count && s_count < 3)) {
                valid = 0;
                break;
            }

            s_ptr++;
            word_ptr++;
        }

        if (valid && s_ptr == s_len && word_ptr == word_len) {
            count++;
        }
    }

    return count;
}