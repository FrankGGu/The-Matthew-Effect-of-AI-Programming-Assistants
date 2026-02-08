#include <stdbool.h>
#include <string.h>

bool canConstruct(char *spell, char *magazine) {
    int counts[26] = {0};

    for (int i = 0; magazine[i] != '\0'; i++) {
        counts[magazine[i] - 'a']++;
    }

    for (int i = 0; spell[i] != '\0'; i++) {
        counts[spell[i] - 'a']--;
        if (counts[spell[i] - 'a'] < 0) {
            return false;
        }
    }

    return true;
}