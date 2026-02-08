#include <string.h>
#include <stdbool.h>

int numJewelsInStones(char * jewels, char * stones){
    bool isJewel[128] = {false};
    int count = 0;

    for (int i = 0; jewels[i] != '\0'; i++) {
        isJewel[(int)jewels[i]] = true;
    }

    for (int i = 0; stones[i] != '\0'; i++) {
        if (isJewel[(int)stones[i]]) {
            count++;
        }
    }

    return count;
}