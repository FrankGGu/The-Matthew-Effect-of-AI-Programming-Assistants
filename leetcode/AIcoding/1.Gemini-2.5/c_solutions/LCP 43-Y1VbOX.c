#include <stdlib.h>

#define GREEN_DURATION 30
#define YELLOW_DURATION 5
#define TOTAL_CYCLE_DURATION (2 * (GREEN_DURATION + YELLOW_DURATION))

int* trafficLightState(int currentTime, int* returnSize) {
    int* states = (int*)malloc(sizeof(int) * 2);

    *returnSize = 2;

    int time_in_cycle = currentTime % TOTAL_CYCLE_DURATION;

    if (time_in_cycle < GREEN_DURATION) {
        states[0] = 2;
        states[1] = 0;
    } else if (time_in_cycle < GREEN_DURATION + YELLOW_DURATION) {
        states[0] = 1;
        states[1] = 0;
    } else if (time_in_cycle < GREEN_DURATION + YELLOW_DURATION + GREEN_DURATION) {
        states[0] = 0;
        states[1] = 2;
    } else {
        states[0] = 0;
        states[1] = 1;
    }

    return states;
}