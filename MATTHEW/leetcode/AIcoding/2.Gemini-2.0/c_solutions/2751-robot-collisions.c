#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* robotCollisions(int* positions, int positionsSize, char* directions, int* healths, int healthsSize, int* returnSize) {
    int n = positionsSize;
    int* result = (int*)malloc(sizeof(int) * n);
    *returnSize = 0;

    typedef struct {
        int index;
        int position;
        int health;
        char direction;
    } Robot;

    Robot* robots = (Robot*)malloc(sizeof(Robot) * n);
    for (int i = 0; i < n; i++) {
        robots[i].index = i;
        robots[i].position = positions[i];
        robots[i].health = healths[i];
        robots[i].direction = directions[i];
    }

    // Sort robots based on position
    qsort(robots, n, sizeof(Robot), [](const void* a, const void* b) {
        return ((Robot*)a)->position - ((Robot*)b)->position;
    });

    typedef struct {
        Robot robot;
        int next;
    } StackNode;

    StackNode* stack = (StackNode*)malloc(sizeof(StackNode) * n);
    int stackSize = 0;

    for (int i = 0; i < n; i++) {
        Robot currentRobot = robots[i];

        while (stackSize > 0 && currentRobot.direction == 'L' && stack[stackSize - 1].robot.direction == 'R') {
            Robot stackTop = stack[stackSize - 1].robot;

            if (stackTop.health > currentRobot.health) {
                stack[stackSize - 1].robot.health--;
                currentRobot.health = 0;
                break;
            } else if (stackTop.health < currentRobot.health) {
                currentRobot.health--;
                stackSize--;
            } else {
                stackSize--;
                currentRobot.health = 0;
                break;
            }
        }

        if (currentRobot.health > 0) {
            stack[stackSize].robot = currentRobot;
            stackSize++;
        }
    }

    for (int i = 0; i < stackSize; i++) {
        result[(*returnSize)++] = stack[i].robot.health;
    }

    int* finalResult = (int*)malloc(sizeof(int) * (*returnSize));
    int finalResultIndex = 0;

    int* originalIndices = (int*)malloc(sizeof(int) * (*returnSize));
    for(int i = 0; i < *returnSize; ++i) {
        originalIndices[i] = stack[i].robot.index;
    }

    for(int i = 0; i < positionsSize; ++i) {
        int found = 0;
        for(int j = 0; j < *returnSize; ++j) {
            if(originalIndices[j] == i) {
                finalResult[finalResultIndex++] = result[j];
                found = 1;
                break;
            }
        }
        if(found == 0) {

        }
    }

    free(result);
    free(robots);
    free(stack);
    free(originalIndices);

    result = finalResult;

    return result;
}