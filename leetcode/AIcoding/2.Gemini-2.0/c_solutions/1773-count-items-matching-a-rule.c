#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countMatches(char ***items, int itemsSize, int *itemsColSize, char *ruleKey, char *ruleValue) {
    int count = 0;
    for (int i = 0; i < itemsSize; i++) {
        if (strcmp(ruleKey, "type") == 0) {
            if (strcmp(items[i][0], ruleValue) == 0) {
                count++;
            }
        } else if (strcmp(ruleKey, "color") == 0) {
            if (strcmp(items[i][1], ruleValue) == 0) {
                count++;
            }
        } else if (strcmp(ruleKey, "name") == 0) {
            if (strcmp(items[i][2], ruleValue) == 0) {
                count++;
            }
        }
    }
    return count;
}