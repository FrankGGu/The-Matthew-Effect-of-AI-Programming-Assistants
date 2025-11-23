#include <string.h>
#include <ctype.h>

int countKeyChanges(char * s){
    int changes = 0;
    if (s == NULL || *s == '\0') {
        return 0;
    }

    char prev = tolower(s[0]);
    for (int i = 1; s[i] != '\0'; i++) {
        char current = tolower(s[i]);
        if (current != prev) {
            changes++;
        }
        prev = current;
    }
    return changes;
}