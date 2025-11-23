int countValidWords(char* sentence) {
    int count = 0;
    char* token = strtok(sentence, " ");

    while (token != NULL) {
        int valid = 1;
        int hyphen_count = 0;
        int n = strlen(token);

        for (int i = 0; i < n; i++) {
            char c = token[i];

            if (isdigit(c)) {
                valid = 0;
                break;
            }

            if (c == '-') {
                hyphen_count++;
                if (hyphen_count > 1 || i == 0 || i == n - 1 || 
                    !isalpha(token[i - 1]) || !isalpha(token[i + 1])) {
                    valid = 0;
                    break;
                }
            }

            if ((c == '!' || c == '.' || c == ',') && i != n - 1) {
                valid = 0;
                break;
            }
        }

        if (valid) {
            count++;
        }

        token = strtok(NULL, " ");
    }

    return count;
}