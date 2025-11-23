#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isValidSerialization(char * preorder){
    int n = strlen(preorder);
    int slots = 1;
    for (int i = 0; i < n; i++) {
        if (preorder[i] == ',') {
            continue;
        }
        if (slots == 0) {
            return false;
        }
        if (preorder[i] == '#') {
            slots--;
            while (i < n && preorder[i] != ',') {
                i++;
            }
        } else {
            slots++;
            while (i < n && preorder[i] != ',') {
                i++;
            }
        }
    }
    return slots == 0;
}