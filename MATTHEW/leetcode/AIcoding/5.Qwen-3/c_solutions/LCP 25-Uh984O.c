#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* findKeyboard(string typed, string printed) {
    int t = 0, p = 0;
    int len_t = strlen(typed);
    int len_p = strlen(printed);

    while (t < len_t && p < len_p) {
        if (typed[t] == printed[p]) {
            t++;
            p++;
        } else {
            return "Not possible";
        }
    }

    if (p < len_p) {
        return "Not possible";
    }

    return "Possible";
}