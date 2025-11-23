int addMinimum(char* word) {
    int n = strlen(word);
    int count = 0;
    int i = 0;

    while (i < n) {
        if (word[i] == 'a') {
            if (i + 1 < n && word[i + 1] == 'b') {
                if (i + 2 < n && word[i + 2] == 'c') {
                    i += 3;
                } else {
                    count++;
                    i += 2;
                }
            } else if (i + 1 < n && word[i + 1] == 'c') {
                count++;
                i += 2;
            } else {
                count += 2;
                i += 1;
            }
        } else if (word[i] == 'b') {
            count++;
            if (i + 1 < n && word[i + 1] == 'c') {
                count++;
                i += 2;
            } else {
                count += 1;
                i += 1;
            }
        } else {
            count += 2;
            i += 1;
        }
    }

    return count;
}