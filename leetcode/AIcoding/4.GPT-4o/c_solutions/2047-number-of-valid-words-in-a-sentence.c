int countValidWords(char * sentence) {
    int count = 0, n = strlen(sentence);
    bool valid = true;
    for (int i = 0; i < n; ) {
        valid = true;
        int word_length = 0;
        while (i < n && sentence[i] == ' ') i++;
        if (i >= n) break;
        while (i < n && sentence[i] != ' ') {
            if (isdigit(sentence[i])) {
                valid = false;
            } else if (sentence[i] == '-' && (i == 0 || i + 1 >= n || !isalpha(sentence[i - 1]) || !isalpha(sentence[i + 1]))) {
                valid = false;
            } else if (sentence[i] == '.' || sentence[i] == '!' || sentence[i] == ',') {
                if (i + 1 != n) valid = false;
            }
            word_length++;
            i++;
        }
        if (valid && word_length > 0) count++;
    }
    return count;
}