#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countVowelSubstrings(char * word){
    int n = strlen(word);
    int count = 0;

    for (int i = 0; i < n; i++) {
        for (int j = i; j < n; j++) {
            bool a = false, e = false, i_ = false, o = false, u = false;
            bool valid = true;

            for (int k = i; k <= j; k++) {
                if (word[k] == 'a') a = true;
                else if (word[k] == 'e') e = true;
                else if (word[k] == 'i') i_ = true;
                else if (word[k] == 'o') o = true;
                else if (word[k] == 'u') u = true;
                else {
                    valid = false;
                    break;
                }
            }

            if (valid && a && e && i_ && o && u) {
                count++;
            }
        }
    }

    return count;
}