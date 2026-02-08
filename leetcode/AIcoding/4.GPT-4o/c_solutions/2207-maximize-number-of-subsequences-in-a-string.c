int maximumSubsequenceCount(char * text, char * pattern) {
    int count = 0;
    int len_text = strlen(text);
    int len_pattern = strlen(pattern);
    int count_p1 = 0, count_p2 = 0;

    for (int i = 0; i < len_text; i++) {
        if (text[i] == pattern[0]) {
            count_p1++;
        }
        if (text[i] == pattern[1]) {
            count_p2++;
        }
    }

    int result = count_p1 + count_p2;
    if (pattern[0] == pattern[1]) {
        return count_p1 + (count_p1 * (count_p1 - 1)) / 2;
    }

    for (int i = 0; i < len_text; i++) {
        if (text[i] == pattern[1]) {
            count += count_p1;
        }
        if (text[i] == pattern[0]) {
            count_p1--;
        }
    }

    return count + count_p2;
}