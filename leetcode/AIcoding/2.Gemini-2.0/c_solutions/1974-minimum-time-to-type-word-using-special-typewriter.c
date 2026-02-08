#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minTimeToType(char * word){
    int time = 0;
    char current = 'a';
    for (int i = 0; word[i] != '\0'; i++) {
        int diff = abs(word[i] - current);
        time += (diff < 13) ? diff : (26 - diff);
        time++;
        current = word[i];
    }
    return time;
}