#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numUniqueEmails(char ** emails, int emailsSize){
    int count = 0;
    char **uniqueEmails = (char **)malloc(emailsSize * sizeof(char *));
    for (int i = 0; i < emailsSize; i++) {
        uniqueEmails[i] = NULL;
    }

    for (int i = 0; i < emailsSize; i++) {
        char *email = emails[i];
        char *localName = (char *)malloc(strlen(email) + 1);
        char *domainName = (char *)malloc(strlen(email) + 1);
        int localIndex = 0;
        int domainIndex = 0;
        int atFound = 0;
        for (int j = 0; email[j] != '\0'; j++) {
            if (email[j] == '@') {
                atFound = 1;
            }
            if (atFound == 0) {
                if (email[j] == '.') {
                    continue;
                } else if (email[j] == '+') {
                    while (email[j] != '@') {
                        j++;
                    }
                    localName[localIndex] = '\0';
                    domainName[domainIndex++] = email[j++];
                    atFound = 1;
                    while (email[j] != '\0') {
                        domainName[domainIndex++] = email[j++];
                    }
                    domainName[domainIndex] = '\0';
                    break;
                } else {
                    localName[localIndex++] = email[j];
                }
            } else {
                domainName[domainIndex++] = email[j];
            }
        }
        if (atFound == 0) {
            free(localName);
            free(domainName);
            continue;
        }
        if (localName[0] != '\0' && atFound == 0) {
            localName[localIndex] = '\0';
        }
        if (domainName[0] != '\0' && atFound == 0) {
             domainName[domainIndex] = '\0';
        }

        if (atFound == 0) {
            free(localName);
            free(domainName);
            continue;
        }

        localName[localIndex] = '\0';
        domainName[domainIndex] = '\0';

        char *normalizedEmail = (char *)malloc(strlen(localName) + strlen(domainName) + 2);
        strcpy(normalizedEmail, localName);
        strcat(normalizedEmail, "@");
        strcat(normalizedEmail, domainName);

        int isUnique = 1;
        for (int k = 0; k < count; k++) {
            if (strcmp(uniqueEmails[k], normalizedEmail) == 0) {
                isUnique = 0;
                break;
            }
        }

        if (isUnique) {
            uniqueEmails[count++] = normalizedEmail;
        } else {
            free(normalizedEmail);
        }

        free(localName);
        free(domainName);
    }

    for (int i = 0; i < emailsSize; i++) {
        if (uniqueEmails[i] != NULL) {

        }
    }

    free(uniqueEmails);
    return count;
}