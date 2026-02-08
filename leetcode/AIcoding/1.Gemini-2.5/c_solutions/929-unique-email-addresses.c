#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

static int compareStrings(const void* a, const void* b) {
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
        return 0; // Handle allocation failure
    }

    for (int j = 0; j < emailsSize; j++) {
        char* email = emails[j];
        char* canonical_email = (char*)malloc(101 * sizeof(char));
        if (canonical_email == NULL) {
            // Clean up previously allocated memory before returning
            for (int k = 0; k < j; k++) {
                free(canonicalEmails[k]);
            }
            free(canonicalEmails);
            return 0; // Handle allocation failure
        }
        int k = 0;

        bool plus_found = false;
        int i = 0;

        while (email[i] != '@') {
            if (email[i] == '.') {
                // Skip
            } else if (email[i] == '+') {
                plus_found = true;
            } else {
                if (!plus_found) {
                    canonical_email[k++] = email[i];
                }
            }
            i++;
        }

        canonical_email[k++] = '@';

        i++;
        while (email[i] != '\0') {
            canonical_email[k++] = email[i];
            i++;
        }
        canonical_email[k] = '\0';

        canonicalEmails[j] = canonical_email;
    }

    qsort(canonicalEmails, emailsSize, sizeof(char*), compareStrings);

    int unique_count = 0;
    if (emailsSize > 0) {
        unique_count = 1;
        for (int j = 1; j < emailsSize; j++) {
            if (strcmp(canonicalEmails[j], canonicalEmails[j-1]) != 0) {
                unique_count++;
            }
        }
    }

    for (int j = 0; j < emailsSize; j++) {
        free(canonicalEmails[j]);
    }
    free(canonicalEmails);

    return unique_count;
}