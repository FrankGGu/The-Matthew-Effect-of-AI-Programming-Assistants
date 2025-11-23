#include <stdlib.h>
#include <string.h>

typedef struct {
    int id;
    int position;
    int health;
    char direction;
} Robot;

int compareRobotsByPosition(const void *a, const void *b) {
    return ((Robot *)a)->position - ((Robot *)b)->position;
}

int compareRobotsById(const void *a, const void *b) {
    return ((Robot *)a)->id - ((Robot *)b)->id;
}

int* robotCollisions(int* positions, int positionsSize, int* healths, int healthsSize, char* directions, int* returnSize) {
    // 1. Create an array of Robot structs, storing original indices
    Robot* robots = (Robot*)malloc(positionsSize * sizeof(Robot));
    for (int i = 0; i < positionsSize; i++) {
        robots[i].id = i; // Store original index
        robots[i].position = positions[i];
        robots[i].health = healths[i];
        robots[i].direction = directions[i];
    }

    // 2. Sort the robots array by their positions
    qsort(robots, positionsSize, sizeof(Robot), compareRobotsByPosition);

    // 3. Initialize a stack to manage 'R' moving robots and a temporary list for survivors
    // The stack will store robots that are moving 'R' and are still active
    Robot* robot_stack = (Robot*)malloc(positionsSize * sizeof(Robot));
    int stack_top = -1; // -1 indicates an empty stack

    // The survivors_temp list will store robots that have survived all collisions
    Robot* survivors_temp = (Robot*)malloc(positionsSize * sizeof(Robot));
    int survivors_count = 0;

    // 4. Iterate through the sorted robots to simulate collisions
    for (int i = 0; i < positionsSize; i++) {
        Robot current_robot = robots[i];

        if (current_robot.direction == 'R') {
            // If the current robot moves 'R', push it onto the stack
            stack_top++;
            robot_stack[stack_top] = current_robot;
        } else { // current_robot.direction == 'L'
            // If the current robot moves 'L', it might collide with 'R' robots on the stack
            while (stack_top >= 0 && robot_stack[stack_top].direction == 'R') {
                Robot top_robot = robot_stack[stack_top]; // Peek at the top robot on the stack

                if (top_robot.health == current_robot.health) {
                    // Both robots have equal health, both are destroyed
                    stack_top--; // Pop top_robot (destroyed)
                    current_robot.health = 0; // current_robot is destroyed
                    break; // current_robot is gone, no more collisions for it
                } else if (top_robot.health > current_robot.health) {
                    // Top robot has higher health, current_robot is destroyed
                    robot_stack[stack_top].health--; // top_robot's health decreases
                    current_robot.health = 0; // current_robot is destroyed
                    break; // current_robot is gone
                } else { // top_robot.health < current_robot.health
                    // Current robot has higher health, top_robot is destroyed
                    stack_top--; // Pop top_robot (destroyed)
                    current_robot.health--; // current_robot's health decreases
                    // current_robot continues to collide with the next robot on the stack
                }
            }
            // If current_robot survived all potential collisions (health > 0)
            // or if the stack was empty, it means it moved left past all 'R' robots
            // and won't collide with anything else. Add it to survivors.
            if (current_robot.health > 0) {
                survivors_temp[survivors_count++] = current_robot;
            }
        }
    }

    // 5. After iterating through all sorted robots, add any remaining 'R' robots from the stack to survivors_temp
    while (stack_top >= 0) {
        survivors_temp[survivors_count++] = robot_stack[stack_top--];
    }

    // 6. Sort the survivors_temp list by their original IDs to get the healths in the correct output order
    qsort(survivors_temp, survivors_count, sizeof(Robot), compareRobotsById);

    // 7. Extract the health values from the sorted survivors_temp into the final result array
    int* result = (int*)malloc(survivors_count * sizeof(int));
    for (int i = 0; i < survivors_count; i++) {
        result[i] = survivors_temp[i].health;
    }

    *returnSize = survivors_count;

    // Free all dynamically allocated memory except the result array
    free(robots);
    free(robot_stack);
    free(survivors_temp);

    return result;
}