#include <string.h>

int countMatches(char*** items, int itemsSize, int* itemsColSize, char* ruleKey, char* ruleValue) {
    int matches = 0;
    int keyIndex;

    if (strcmp(ruleKey, "type") == 0) {
        keyIndex = 0;
    } else if (strcmp(ruleKey, "color") == 0) {
        keyIndex = 1;
    } else { // ruleKey must be "name"
        keyIndex = 2;
    }

    for (int i = 0; i < itemsSize; i++) {
        if (strcmp(items[i][keyIndex], ruleValue) == 0) {
            matches++;
        }
    }

    return matches;
}