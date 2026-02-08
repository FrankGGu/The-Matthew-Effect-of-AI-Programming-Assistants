#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef enum {
    NORTH = 0,
    EAST = 1,
    SOUTH = 2,
    WEST = 3
} Direction;

typedef struct {
    int carId;
    Direction arrivalDirection;
    Direction targetDirection;
} Car;

typedef struct {
    sem_t mutex;
    int road[4][4];
} TrafficSystem;

TrafficSystem* trafficSystemCreate() {
    TrafficSystem* obj = (TrafficSystem*)malloc(sizeof(TrafficSystem));
    sem_init(&obj->mutex, 0, 1);
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            obj->road[i][j] = 0;
        }
    }
    return obj;
}

void carArrived(TrafficSystem* obj, int carId, int arrivalDirection, int targetDirection) {
    sem_wait(&obj->mutex);

    int arrival = arrivalDirection;
    int target = targetDirection;

    while (1) {
        if (arrival == NORTH && target == EAST) {
            if (obj->road[NORTH][EAST] == 0 && obj->road[WEST][SOUTH] == 0) {
                obj->road[NORTH][EAST] = 1;
                printf("Car %d from NORTH to EAST\n", carId);
                break;
            }
        } else if (arrival == NORTH && target == SOUTH) {
            if (obj->road[NORTH][SOUTH] == 0) {
                obj->road[NORTH][SOUTH] = 1;
                printf("Car %d from NORTH to SOUTH\n", carId);
                break;
            }
        } else if (arrival == NORTH && target == WEST) {
            if (obj->road[NORTH][WEST] == 0 && obj->road[EAST][SOUTH] == 0) {
                obj->road[NORTH][WEST] = 1;
                printf("Car %d from NORTH to WEST\n", carId);
                break;
            }
        } else if (arrival == EAST && target == NORTH) {
            if (obj->road[EAST][NORTH] == 0 && obj->road[SOUTH][WEST] == 0) {
                obj->road[EAST][NORTH] = 1;
                printf("Car %d from EAST to NORTH\n", carId);
                break;
            }
        } else if (arrival == EAST && target == SOUTH) {
            if (obj->road[EAST][SOUTH] == 0) {
                obj->road[EAST][SOUTH] = 1;
                printf("Car %d from EAST to SOUTH\n", carId);
                break;
            }
        } else if (arrival == EAST && target == WEST) {
            if (obj->road[EAST][WEST] == 0 && obj->road[NORTH][SOUTH] == 0) {
                obj->road[EAST][WEST] = 1;
                printf("Car %d from EAST to WEST\n", carId);
                break;
            }
        } else if (arrival == SOUTH && target == NORTH) {
            if (obj->road[SOUTH][NORTH] == 0) {
                obj->road[SOUTH][NORTH] = 1;
                printf("Car %d from SOUTH to NORTH\n", carId);
                break;
            }
        } else if (arrival == SOUTH && target == EAST) {
            if (obj->road[SOUTH][EAST] == 0 && obj->road[WEST][NORTH] == 0) {
                obj->road[SOUTH][EAST] = 1;
                printf("Car %d from SOUTH to EAST\n", carId);
                break;
            }
        } else if (arrival == SOUTH && target == WEST) {
            if (obj->road[SOUTH][WEST] == 0 && obj->road[EAST][NORTH] == 0) {
                obj->road[SOUTH][WEST] = 1;
                printf("Car %d from SOUTH to WEST\n", carId);
                break;
            }
        } else if (arrival == WEST && target == NORTH) {
            if (obj->road[WEST][NORTH] == 0 && obj->road[SOUTH][EAST] == 0) {
                obj->road[WEST][NORTH] = 1;
                printf("Car %d from WEST to NORTH\n", carId);
                break;
            }
        } else if (arrival == WEST && target == EAST) {
            if (obj->road[WEST][EAST] == 0 && obj->road[NORTH][SOUTH] == 0) {
                obj->road[WEST][EAST] = 1;
                printf("Car %d from WEST to EAST\n", carId);
                break;
            }
        } else if (arrival == WEST && target == SOUTH) {
            if (obj->road[WEST][SOUTH] == 0 && obj->road[NORTH][EAST] == 0) {
                obj->road[WEST][SOUTH] = 1;
                printf("Car %d from WEST to SOUTH\n", carId);
                break;
            }
        } else {
            printf("Invalid direction combination\n");
            break;
        }
    }

    if (arrival == NORTH && target == EAST) {
        obj->road[NORTH][EAST] = 0;
    } else if (arrival == NORTH && target == SOUTH) {
        obj->road[NORTH][SOUTH] = 0;
    } else if (arrival == NORTH && target == WEST) {
        obj->road[NORTH][WEST] = 0;
    } else if (arrival == EAST && target == NORTH) {
        obj->road[EAST][NORTH] = 0;
    } else if (arrival == EAST && target == SOUTH) {
        obj->road[EAST][SOUTH] = 0;
    } else if (arrival == EAST && target == WEST) {
        obj->road[EAST][WEST] = 0;
    } else if (arrival == SOUTH && target == NORTH) {
        obj->road[SOUTH][NORTH] = 0;
    } else if (arrival == SOUTH && target == EAST) {
        obj->road[SOUTH][EAST] = 0;
    } else if (arrival == SOUTH && target == WEST) {
        obj->road[SOUTH][WEST] = 0;
    } else if (arrival == WEST && target == NORTH) {
        obj->road[WEST][NORTH] = 0;
    } else if (arrival == WEST && target == EAST) {
        obj->road[WEST][EAST] = 0;
    } else if (arrival == WEST && target == SOUTH) {
        obj->road[WEST][SOUTH] = 0;
    }

    sem_post(&obj->mutex);
}

void trafficSystemFree(TrafficSystem* obj) {
    sem_destroy(&obj->mutex);
    free(obj);
}