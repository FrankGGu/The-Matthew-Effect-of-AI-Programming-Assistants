int countConsistentStrings(char * allowed, char ** words, int wordsSize){
    int allowed_chars[26] = {0};
    for (int i = 0; allowed[i] != '\0'; i++) {
        allowed_chars[allowed[i] - 'a'] = 1;
    }

    int consistent_count = 0;
    for (int i = 0; i < wordsSize; i++) {
        char *current_word = words[i];
        int is_consistent = 1;
        for (int j = 0; current_word[j] != '\0'; j++) {
            if (allowed_chars[current_word[j] - 'a'] == 0) {
                is_consistent = 0;
                break;
            }
        }
        if (is_consistent) {
            consistent_count++;
        }
    }
    return consistent_count;
}