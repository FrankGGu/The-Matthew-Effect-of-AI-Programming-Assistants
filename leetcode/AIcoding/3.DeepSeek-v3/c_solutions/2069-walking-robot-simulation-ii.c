typedef struct {
    int width;
    int height;
    int x;
    int y;
    int dir;
    int moved;
} Robot;

Robot* robotCreate(int width, int height) {
    Robot* obj = (Robot*)malloc(sizeof(Robot));
    obj->width = width;
    obj->height = height;
    obj->x = 0;
    obj->y = 0;
    obj->dir = 0;
    obj->moved = 0;
    return obj;
}

void robotStep(Robot* obj, int num) {
    if (num == 0) return;

    obj->moved = 1;
    int perimeter = 2 * (obj->width + obj->height) - 4;
    num %= perimeter;
    if (num == 0) num = perimeter;

    while (num > 0) {
        if (obj->dir == 0) {
            int maxStep = obj->width - 1 - obj->x;
            if (num <= maxStep) {
                obj->x += num;
                num = 0;
            } else {
                num -= (maxStep + 1);
                obj->x = obj->width - 1;
                obj->dir = 1;
            }
        } else if (obj->dir == 1) {
            int maxStep = obj->height - 1 - obj->y;
            if (num <= maxStep) {
                obj->y += num;
                num = 0;
            } else {
                num -= (maxStep + 1);
                obj->y = obj->height - 1;
                obj->dir = 2;
            }
        } else if (obj->dir == 2) {
            int maxStep = obj->x;
            if (num <= maxStep) {
                obj->x -= num;
                num = 0;
            } else {
                num -= (maxStep + 1);
                obj->x = 0;
                obj->dir = 3;
            }
        } else if (obj->dir == 3) {
            int maxStep = obj->y;
            if (num <= maxStep) {
                obj->y -= num;
                num = 0;
            } else {
                num -= (maxStep + 1);
                obj->y = 0;
                obj->dir = 0;
            }
        }
    }
}

int* robotGetPos(Robot* obj, int* retSize) {
    int* res = (int*)malloc(2 * sizeof(int));
    res[0] = obj->x;
    res[1] = obj->y;
    *retSize = 2;
    return res;
}

char* robotGetDir(Robot* obj) {
    if (!obj->moved && obj->x == 0 && obj->y == 0) {
        return "East";
    }
    if (obj->dir == 0) return "East";
    if (obj->dir == 1) return "North";
    if (obj->dir == 2) return "West";
    return "South";
}

void robotFree(Robot* obj) {
    free(obj);
}