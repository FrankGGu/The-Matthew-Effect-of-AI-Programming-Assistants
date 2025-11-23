#include <stdbool.h>
#include <string.h>

bool areOccurrencesEqual(char * s){
    int counts[26] = {0};
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        counts[s[i] - 'a']++;
    }

    int first_occurrence_count = -1;

    for (int i = 0; i < 26; i++) {
        if (counts[i] > 0) {
            if (first_occurrence_count == -1) {
                first_occurrence_count = counts[i];
            } else if (counts[i] != first_occurrence_count) {
                return false;
            }
        }
    }

    return true;
}