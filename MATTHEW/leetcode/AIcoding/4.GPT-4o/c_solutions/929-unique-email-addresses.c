#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_EMAILS 10000
#define MAX_LEN 100

int numUniqueEmails(char ** emails, int emailsSize) {
    char *uniqueEmails[MAX_EMAILS];
    int uniqueCount = 0;

    for (int i = 0; i < emailsSize; i++) {
        char local[MAX_LEN], domain[MAX_LEN];
        int j = 0;

        while (emails[i][j] != '@') {
            if (emails[i][j] == '+') break;
            if (emails[i][j] != '.') local[strlen(local)] = emails[i][j];
            j++;
        }
        local[j] = '\0';

        strcpy(domain, emails[i] + j);
        char fullEmail[MAX_LEN];
        sprintf(fullEmail, "%s%s", local, domain);

        int found = 0;
        for (int k = 0; k < uniqueCount; k++) {
            if (strcmp(uniqueEmails[k], fullEmail) == 0) {
                found = 1;
                break;
            }
        }
        if (!found) {
            uniqueEmails[uniqueCount++] = strdup(fullEmail);
        }
    }

    for (int i = 0; i < uniqueCount; i++) {
        free(uniqueEmails[i]);
    }

    return uniqueCount;
}