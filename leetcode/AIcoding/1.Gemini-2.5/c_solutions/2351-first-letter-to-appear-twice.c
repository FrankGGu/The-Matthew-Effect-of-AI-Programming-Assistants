#include <stdbool.h>

char repeatedCharacter(char * s){
    bool seen[26] = {false};
    int i = 0;
    while (s[i] != '\0') {
        int index = s[i] - 'a';
        if (seen[index]) {
            return s[i];
        }
        seen[index] = true;
        i++;
    }
    return ' '; // Should not be reached based on problem constraints
}