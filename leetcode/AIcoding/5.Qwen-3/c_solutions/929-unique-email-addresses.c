#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numUniqueEmails(char** emails, int emailsSize) {
    char** uniqueEmails = (char**)malloc(emailsSize * sizeof(char*));
    int count = 0;

    for (int i = 0; i < emailsSize; i++) {
        char* email = emails[i];
        char* local = (char*)malloc(strlen(email) + 1);
        char* domain = (char*)malloc(strlen(email) + 1);
        strcpy(local, email);

        char* at = strchr(local, '@');
        if (at != NULL) {
            *at = '\0';
            char* plus = strchr(local, '+');
            if (plus != NULL) {
                *plus = '\0';
            }
            strcat(local, at);
        }

        int found = 0;
        for (int j = 0; j < count; j++) {
            if (strcmp(local, uniqueEmails[j]) == 0) {
                found = 1;
                break;
            }
        }

        if (!found) {
            uniqueEmails[count++] = local;
        } else {
            free(local);
        }
    }

    free(uniqueEmails);
    return count;
}