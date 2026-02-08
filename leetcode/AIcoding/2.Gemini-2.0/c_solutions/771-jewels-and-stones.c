#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numJewelsInStones(char * jewels, char * stones){
    int count = 0;
    int jewels_len = strlen(jewels);
    int stones_len = strlen(stones);

    for(int i = 0; i < stones_len; i++){
        for(int j = 0; j < jewels_len; j++){
            if(stones[i] == jewels[j]){
                count++;
                break;
            }
        }
    }

    return count;
}