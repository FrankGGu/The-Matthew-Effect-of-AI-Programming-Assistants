int numUniqueEmails(char** emails, int emailsSize) {
    char** unique = (char**)malloc(emailsSize * sizeof(char*));
    int count = 0;

    for (int i = 0; i < emailsSize; i++) {
        char* email = emails[i];
        char* clean = (char*)malloc(strlen(email) + 1);
        int idx = 0;
        int atFound = 0;
        int plusFound = 0;

        for (int j = 0; email[j] != '\0'; j++) {
            if (email[j] == '@') {
                atFound = 1;
            }

            if (!atFound) {
                if (email[j] == '+') {
                    plusFound = 1;
                }
                if (email[j] != '.' && !plusFound) {
                    clean[idx++] = email[j];
                }
            } else {
                clean[idx++] = email[j];
            }
        }
        clean[idx] = '\0';

        int found = 0;
        for (int k = 0; k < count; k++) {
            if (strcmp(unique[k], clean) == 0) {
                found = 1;
                break;
            }
        }

        if (!found) {
            unique[count++] = clean;
        } else {
            free(clean);
        }
    }

    for (int i = 0; i < count; i++) {
        free(unique[i]);
    }
    free(unique);

    return count;
}