#include <string.h>
#include <stdlib.h>

int minTimeToType(char * word){
    int total_time = 0;
    char current_char = 'a';
    int i;
    int len = strlen(word);

    for (i = 0; i < len; i++) {
        char target_char = word[i];
        int diff = abs(target_char - current_char);
        int rotation_time = diff < (26 - diff) ? diff : (26 - diff);

        total_time += rotation_time;
        total_time += 1; // For pressing the key
        current_char = target_char;
    }

    return total_time;
}