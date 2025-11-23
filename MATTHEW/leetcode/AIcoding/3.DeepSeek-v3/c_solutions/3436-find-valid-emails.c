#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char** filterEmails(char** emails, int emailsSize, int* returnSize) {
    char** result = (char**)malloc(emailsSize * sizeof(char*));
    *returnSize = 0;

    for (int i = 0; i < emailsSize; i++) {
        char* email = emails[i];
        int at_pos = -1;
        int len = strlen(email);

        for (int j = 0; j < len; j++) {
            if (email[j] == '@') {
                at_pos = j;
                break;
            }
        }

        if (at_pos == -1) continue;

        char local[101] = {0};
        char domain[101] = {0};
        strncpy(local, email, at_pos);
        strcpy(domain, email + at_pos);

        char filtered_local[101] = {0};
        int idx = 0;

        for (int j = 0; j < at_pos; j++) {
            if (local[j] == '+') {
                break;
            } else if (local[j] != '.') {
                filtered_local[idx++] = local[j];
            }
        }

        char* valid_email = (char*)malloc((strlen(filtered_local) + strlen(domain) + 1) * sizeof(char));
        sprintf(valid_email, "%s%s", filtered_local, domain);

        result[*returnSize] = valid_email;
        (*returnSize)++;
    }

    return result;
}

int numUniqueEmails(char** emails, int emailsSize) {
    int returnSize;
    char** filtered = filterEmails(emails, emailsSize, &returnSize);

    int unique_count = 0;
    for (int i = 0; i < returnSize; i++) {
        int is_unique = 1;
        for (int j = 0; j < i; j++) {
            if (strcmp(filtered[i], filtered[j]) == 0) {
                is_unique = 0;
                break;
            }
        }
        if (is_unique) {
            unique_count++;
        }
    }

    for (int i = 0; i < returnSize; i++) {
        free(filtered[i]);
    }
    free(filtered);

    return unique_count;
}