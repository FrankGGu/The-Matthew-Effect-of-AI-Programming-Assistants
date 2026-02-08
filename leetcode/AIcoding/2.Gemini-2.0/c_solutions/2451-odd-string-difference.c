#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * oddString(char ** words, int wordsSize){
    int diffs[wordsSize][words[0][1] == '\0' ? 0 : strlen(words[0]) - 1];
    int len = words[0][1] == '\0' ? 0 : strlen(words[0]) - 1;

    for (int i = 0; i < wordsSize; i++) {
        for (int j = 0; j < len; j++) {
            diffs[i][j] = words[i][j + 1] - words[i][j];
        }
    }

    if (wordsSize == 2) {
        if (diffs[0][0] != diffs[1][0]) {
            return words[0][0] - words[1][0] == diffs[0][0] ? words[1] : words[0];
        } else {
            return "";
        }
    }

    int first_diff = 0;
    int second_diff = 0;
    int third_diff = 0;

    for (int i = 0; i < len; i++) {
        first_diff += diffs[0][i];
        second_diff += diffs[1][i];
        third_diff += diffs[2][i];
    }

    if (first_diff != second_diff && first_diff != third_diff) {
        if (second_diff == third_diff) return words[0];
        else return words[1];
    } else if (second_diff != first_diff && second_diff != third_diff) {
        return words[1];
    } else {
        for(int i = 3; i < wordsSize; i++) {
            int current_diff = 0;
            for(int j = 0; j < len; j++) {
                current_diff += diffs[i][j];
            }
            if(current_diff != first_diff) {
                return words[i];
            }
        }
    }

    return "";
}