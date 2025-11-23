#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_EMAIL_LEN 256

typedef struct {
    char* email;
} Email;

Email* findValidEmails(char** emails, int emailsSize, int* returnSize) {
    Email* result = (Email*)malloc(0);
    *returnSize = 0;

    for (int i = 0; i < emailsSize; i++) {
        char* email = emails[i];
        int valid = 1;
        int atCount = 0;
        int localPartLen = 0;
        int domainPartLen = 0;

        for (int j = 0; email[j] != '\0'; j++) {
            if (email[j] == '@') {
                atCount++;
                if (atCount > 1) {
                    valid = 0;
                    break;
                }
                localPartLen = j;
                domainPartLen = strlen(email) - j - 1;
            } else if (email[j] == '.') {
                if (j == 0 || j == strlen(email) - 1) {
                    valid = 0;
                    break;
                }
            } else if (!isalnum(email[j]) && email[j] != '_' && email[j] != '.' && email[j] != '-') {
                valid = 0;
                break;
            }
        }

        if (atCount != 1 || localPartLen == 0 || domainPartLen == 0 || valid == 0) {
            continue;
        }

        result = (Email*)realloc(result, (*returnSize + 1) * sizeof(Email));
        result[*returnSize].email = strdup(email);
        (*returnSize)++;
    }

    return result;
}