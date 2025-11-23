int countCells(char* s) {
    int len = strlen(s);
    int count = 0;

    for (int i = 0; i < len; i++) {
        if (s[i] == 'V') {
            for (int j = i + 1; j < len; j++) {
                if (s[j] == 'H') {
                    count++;
                }
            }
        } else if (s[i] == 'H') {
            for (int j = i + 1; j < len; j++) {
                if (s[j] == 'V') {
                    count++;
                }
            }
        }
    }

    return count;
}