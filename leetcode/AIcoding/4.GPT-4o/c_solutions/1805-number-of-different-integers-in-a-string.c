#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <set>

int numDifferentIntegers(char *word) {
    std::set<std::string> uniqueIntegers;
    char *ptr = word;

    while (*ptr) {
        while (*ptr && !isdigit(*ptr)) {
            ptr++;
        }
        if (*ptr) {
            char *start = ptr;
            while (*ptr && isdigit(*ptr)) {
                ptr++;
            }
            while (start < ptr - 1 && *start == '0') {
                start++;
            }
            std::string num(start, ptr);
            if (num.empty()) num = "0";
            uniqueIntegers.insert(num);
        }
    }

    return uniqueIntegers.size();
}