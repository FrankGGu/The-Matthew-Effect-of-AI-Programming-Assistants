/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
typedef struct {
    int position;
    int health;
    char direction;
    int index;
} Robot;

int cmp(const void* a, const void* b) {
    Robot* r1 = (Robot*)a;
    Robot* r2 = (Robot*)b;
    return r1->position - r2->position;
}

int* survivedRobotsHealths(int* positions, int positionsSize, int* healths, int healthsSize, char* directions, int* returnSize) {
    int n = positionsSize;
    Robot* robots = malloc(n * sizeof(Robot));
    for (int i = 0; i < n; i++) {
        robots[i].position = positions[i];
        robots[i].health = healths[i];
        robots[i].direction = directions[i];
        robots[i].index = i;
    }

    qsort(robots, n, sizeof(Robot), cmp);

    int* result = malloc(n * sizeof(int));
    int* stack = malloc(n * sizeof(int));
    int top = -1;

    for (int i = 0; i < n; i++) {
        if (robots[i].direction == 'R') {
            stack[++top] = i;
        } else {
            while (top != -1 && robots[stack[top]].direction == 'R' && robots[i].direction == 'L') {
                if (robots[stack[top]].health > robots[i].health) {
                    robots[stack[top]].health--;
                    robots[i].health = 0;
                    break;
                } else if (robots[stack[top]].health < robots[i].health) {
                    robots[i].health--;
                    robots[stack[top]].health = 0;
                    top--;
                } else {
                    robots[stack[top]].health = 0;
                    robots[i].health = 0;
                    top--;
                    break;
                }
            }
            if (robots[i].health > 0) {
                stack[++top] = i;
            }
        }
    }

    *returnSize = 0;
    for (int i = 0; i < n; i++) {
        if (robots[i].health > 0) {
            result[(*returnSize)++] = robots[i].health;
        }
    }

    int* final = malloc((*returnSize) * sizeof(int));
    int* indices = malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        indices[robots[i].index] = i;
    }

    int idx = 0;
    for (int i = 0; i < n; i++) {
        int pos = indices[i];
        if (robots[pos].health > 0) {
            final[idx++] = robots[pos].health;
        }
    }

    free(robots);
    free(stack);
    free(indices);
    free(result);

    return final;
}