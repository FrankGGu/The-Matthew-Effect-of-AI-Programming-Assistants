#include <string.h>

char * reversePrefix(char * word, char ch){
    int len = strlen(word);
    int i = 0;
    int found_idx = -1;

    for (i = 0; i < len; i++) {
        if (word[i] == ch) {
            found_idx = i;
            break;
        }
    }

    if (found_idx != -1) {
        int start = 0;
        int end = found_idx;
        while (start < end) {
            char temp = word[start];
            word[start] = word[end];
            word[end] = temp;
            start++;
            end--;
        }
    }

    return word;
}