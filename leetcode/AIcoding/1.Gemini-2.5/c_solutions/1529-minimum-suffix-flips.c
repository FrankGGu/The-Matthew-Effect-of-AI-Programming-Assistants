#include <string.h>

int minFlips(char * target){
    int flips = 0;
    char current_state = '0';

    int n = strlen(target);
    for (int i = 0; i < n; i++) {
        if (target[i] != current_state) {
            flips++;
            current_state = (current_state == '0' ? '1' : '0');
        }
    }
    return flips;
}