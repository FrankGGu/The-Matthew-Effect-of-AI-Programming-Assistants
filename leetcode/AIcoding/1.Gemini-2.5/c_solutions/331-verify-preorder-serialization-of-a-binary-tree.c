#include <stdbool.h>
#include <string.h>

bool isValidSerialization(char *preorder) {
    int slots = 1;
    int n = strlen(preorder);
    for (int i = 0; i < n; ++i) {
        if (slots == 0) {
            return false;
        }
        if (preorder[i] == ',') {
            continue;
        }
        if (preorder[i] == '#') {
            slots--;
        } else {
            slots++;
            while (i < n && preorder[i] != ',') {
                i++;
            }
            i--; 
        }
    }
    return slots == 0;
}