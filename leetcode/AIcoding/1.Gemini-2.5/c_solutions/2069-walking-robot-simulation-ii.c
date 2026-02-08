#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int width;
    int height;
    int perimeter;
    int x;
    int y;
    int dir; // 0: East, 1: North, 2: West, 3: South
    bool is_initial_zero_zero; // True if robot is at (0,0) and no moves have been made yet
} Robot;

Robot* robotCreate(int width, int height) {
    Robot* obj = (Robot*)malloc(sizeof(Robot));
    obj->width = width;
    obj->height = height;
    obj->perimeter = 2 * (width - 1) + 2 * (height - 1);
    obj->x = 0;
    obj->y = 0;
    obj->dir = 0; // East
    obj->is_initial_zero_zero = true;
    return obj;
}

void robotMove(Robot* obj, int steps) {
    int w_minus_1 = obj->width - 1;
    int h_minus_1 = obj->height - 1;

    // Handle 1x1 grid case (perimeter is 0)
    if (obj->perimeter == 0) {
        obj->x = 0;
        obj->y = 0;
        obj->dir = 0; // Stays at (0,0) facing East
        obj->is_initial_zero_zero = false;
        return;
    }

    // Handle initial state (0,0) with 0 steps
    if (obj->is_initial_zero_zero && steps == 0) {
        return;
    }
    obj->is_initial_zero_zero = false;

    // Convert current (x,y) to a linear position on the perimeter
    int current_pos_on_perimeter;
    if (obj->y == 0 && obj->x < w_minus_1) { // Bottom edge, not rightmost corner
        current_pos_on_perimeter = obj->x;
    } else if (obj->x == w_minus_1 && obj->y < h_minus_1) { // Right edge, not topmost corner
        current_pos_on_perimeter = w_minus_1 + obj->y;
    } else if (obj->y == h_minus_1 && obj->x > 0) { // Top edge, not leftmost corner
        current_pos_on_perimeter = w_minus_1 + h_minus_1 + (w_minus_1 - obj->x);
    } else { // Left edge, or (0,0) if width=1 or height=1
        current_pos_on_perimeter = w_minus_1 + h_minus_1 + w_minus_1 + (h_minus_1 - obj->y);
    }

    // Update linear position
    int new_pos_on_perimeter = (current_pos_on_perimeter + steps) % obj->perimeter;

    // Convert new linear position back to (x,y) and determine direction
    if (new_pos_on_perimeter < w_minus_1) { // Segment 1: (x, 0)
        obj->x = new_pos_on_perimeter;
        obj->y = 0;
        obj->dir = 0; // East
    } else if (new_pos_on_perimeter < w_minus_1 + h_minus_1) { // Segment 2: (w-1, y)
        obj->x = w_minus_1;
        obj->y = new_pos_on_perimeter - w_minus_1;
        obj->dir = 1; // North
    } else if (new_pos_on_perimeter < w_minus_1 + h_minus_1 + w_minus_1) { // Segment 3: (x, h-1)
        obj->x = w_minus_1 - (new_pos_on_perimeter - (w_minus_1 + h_minus_1));
        obj->y = h_minus_1;
        obj->dir = 2; // West
    } else { // Segment 4: (0, y)
        obj->x = 0;
        obj->y = h_minus_1 - (new_pos_on_perimeter - (w_minus_1 + h_minus_1 + w_minus_1));
        obj->dir = 3; // South
    }

    // Special rule for (0,0) direction: if it lands at (0,0) after moving, it faces South.
    // This overrides the default East direction for new_pos_on_perimeter == 0.
    if (new_pos_on_perimeter == 0) {
        obj->dir = 3; // South
    }
}

int* robotGetPos(Robot* obj) {
    int* ret = (int*)malloc(sizeof(int) * 2);
    ret[0] = obj->x;
    ret[1] = obj->y;
    return ret;
}

char* robotGetDir(Robot* obj) {
    if (obj->dir == 0) return "East";
    if (obj->dir == 1) return "North";
    if (obj->dir == 2) return "West";
    return "South";
}

void robotFree(Robot* obj) {
    free(obj);
}