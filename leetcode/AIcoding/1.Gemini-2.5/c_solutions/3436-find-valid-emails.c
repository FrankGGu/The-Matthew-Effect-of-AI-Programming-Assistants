#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

int compareStrings(const void* a, const void* b) {
    const char* s1 = *(const char**)a;
    const char* s2 = *(const char**)b;
    return strcmp(s1, s2);
}

int numUniqueEmails(char** emails, int emailsSize) {
    if (emailsSize == 0) {
        return 0;
    }

    char** canonicalEmails = (char**)malloc(emailsSize * sizeof(char*));
    if (canonicalEmails == NULL) {
        return 0;
    }

    for (int i = 0; i < emailsSize; ++i) {
        char* email = emails[i];
        int len = strlen(email);

        char* canonical = (char*)malloc(len + 1); 
        if (canonical == NULL) {
            for (int j = 0; j < i; ++j) {
                free(canonicalEmails[j]);
            }
            free(canonicalEmails);
            return 0;
        }

        int canonical_idx = 0;
        bool plus_encountered = false;

        char* at_pos = strchr(email, '@');
        int local_name_len = at_pos - email;

        for (int j = 0; j < local_name_len; ++j) {
            if (email[j] == '.') {
                continue;
            }
            if (email[j] == '+') {
                plus_encountered = true;
                continue;
            }
            if (!plus_encountered) {
                canonical[canonical_idx++] = email[j];
            }
        }

        strcpy(canonical + canonical_idx, at_pos); 

        canonicalEmails[i] = canonical;
    }

    qsort(canonicalEmails, emailsSize, sizeof(char*), compareStrings);

    int uniqueCount = 0;
    if (emailsSize > 0) {
        uniqueCount = 1;
        for (int i = 1; i < emailsSize; ++i) {
            if (strcmp(canonicalEmails[i], canonicalEmails[i-1]) != 0) {
                uniqueCount++;
            }
        }
    }

    for (int i = 0; i < emailsSize; ++i) {
        free(canonicalEmails[i]);
    }
    free(canonicalEmails);

    return uniqueCount;
}