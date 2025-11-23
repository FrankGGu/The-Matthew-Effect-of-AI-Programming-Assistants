#include <stdlib.h>
#include <string.h>

int garbageCollection(char **garbage, int garbageSize, int *travel, int travelSize) {
    int total_time = 0;

    int last_M_house = -1;
    int last_P_house = -1;
    int last_G_house = -1;

    for (int i = 0; i < garbageSize; i++) {
        int len = strlen(garbage[i]);
        for (int j = 0; j < len; j++) {
            total_time++;
            char type = garbage[i][j];
            if (type == 'M') {
                last_M_house = i;
            } else if (type == 'P') {
                last_P_house = i;
            } else if (type == 'G') {
                last_G_house = i;
            }
        }
    }

    int *prefix_travel = (int *)malloc(sizeof(int) * garbageSize);
    if (prefix_travel == NULL) {
        return -1; 
    }

    prefix_travel[0] = 0;
    for (int i = 1; i < garbageSize; i++) {
        prefix_travel[i] = prefix_travel[i-1] + travel[i-1];
    }

    if (last_M_house != -1) {
        total_time += prefix_travel[last_M_house];
    }
    if (last_P_house != -1) {
        total_time += prefix_travel[last_P_house];
    }
    if (last_G_house != -1) {
        total_time += prefix_travel[last_G_house];
    }

    free(prefix_travel);

    return total_time;
}