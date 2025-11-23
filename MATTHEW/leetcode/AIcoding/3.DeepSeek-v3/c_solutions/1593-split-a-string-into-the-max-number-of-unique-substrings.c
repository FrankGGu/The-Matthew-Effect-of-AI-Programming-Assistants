int maxUniqueSplit(char* s) {
    int len = strlen(s);
    int max = 0;

    void backtrack(int start, int count, char** seen, int seen_size) {
        if (start == len) {
            if (count > max) max = count;
            return;
        }

        for (int end = start + 1; end <= len; end++) {
            int substr_len = end - start;
            char* substr = (char*)malloc(substr_len + 1);
            strncpy(substr, s + start, substr_len);
            substr[substr_len] = '\0';

            int found = 0;
            for (int i = 0; i < seen_size; i++) {
                if (strcmp(seen[i], substr) == 0) {
                    found = 1;
                    break;
                }
            }

            if (!found) {
                seen[seen_size] = substr;
                backtrack(end, count + 1, seen, seen_size + 1);
            } else {
                free(substr);
            }
        }
    }

    char** seen = (char**)malloc(len * sizeof(char*));
    backtrack(0, 0, seen, 0);

    for (int i = 0; i < len; i++) {
        if (seen[i]) free(seen[i]);
    }
    free(seen);

    return max;
}