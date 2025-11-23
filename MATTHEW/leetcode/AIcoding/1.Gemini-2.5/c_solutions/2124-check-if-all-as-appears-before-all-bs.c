#include <stdbool.h>
#include <string.h>

bool checkString(char * s){
    int n = strlen(s);
    bool foundB = false;

    for (int i = 0; i < n; i++) {
        if (s[i] == 'b') {
            foundB = true;
        } else if (s[i] == 'a') {
            if (foundB) {
                return false;
            }
        }
    }
    return true;
}