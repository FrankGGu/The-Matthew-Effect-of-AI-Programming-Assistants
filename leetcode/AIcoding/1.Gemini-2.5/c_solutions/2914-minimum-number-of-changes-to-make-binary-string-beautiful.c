#include <string.h>

int minChanges(char * s){
    int n = strlen(s);
    int changes = 0;
    for (int i = 0; i < n; i += 3) {
        if (s[i] == '1') {
            changes++;
        }
        if (s[i+1] == '0') {
            changes++;
        }
        if (s[i+2] == '1') {
            changes++;
        }
    }
    return changes;
}