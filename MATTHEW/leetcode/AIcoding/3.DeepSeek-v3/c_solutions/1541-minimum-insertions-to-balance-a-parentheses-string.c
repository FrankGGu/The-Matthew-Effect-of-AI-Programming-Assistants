int minInsertions(char * s) {
    int insertions = 0;
    int right_needed = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == '(') {
            if (right_needed % 2 != 0) {
                insertions++;
                right_needed--;
            }
            right_needed += 2;
        } else {
            right_needed--;
            if (right_needed < 0) {
                insertions++;
                right_needed += 2;
            }
        }
    }

    return insertions + right_needed;
}