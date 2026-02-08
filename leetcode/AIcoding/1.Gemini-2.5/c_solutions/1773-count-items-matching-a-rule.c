#include <string.h>

int countMatches(char*** items, int itemsSize, int* itemsColSize, char* ruleKey, char* ruleValue) {
    int ruleIndex;
    if (strcmp(ruleKey, "type") == 0) {
        ruleIndex = 0;
    } else if (strcmp(ruleKey, "color") == 0) {
        ruleIndex = 1;
    } else { // ruleKey must be "name"
        ruleIndex = 2;
    }

    int matches = 0;
    for (int i = 0; i < itemsSize; i++) {
        if (strcmp(items[i][ruleIndex], ruleValue) == 0) {
            matches++;
        }
    }
    return matches;
}