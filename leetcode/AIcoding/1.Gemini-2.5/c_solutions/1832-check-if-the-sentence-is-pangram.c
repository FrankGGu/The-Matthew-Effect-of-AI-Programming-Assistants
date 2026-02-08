#include <stdbool.h>
#include <string.h>

bool checkIfPangram(char * sentence){
    bool seen[26] = {false};
    int count = 0;
    int len = strlen(sentence);

    for (int i = 0; i < len; i++) {
        char c = sentence[i];
        if (c >= 'a' && c <= 'z') {
            int index = c - 'a';
            if (!seen[index]) {
                seen[index] = true;
                count++;
            }
        }
    }

    return count == 26;
}