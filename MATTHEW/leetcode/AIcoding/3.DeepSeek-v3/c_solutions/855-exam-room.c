typedef struct {
    int* seats;
    int capacity;
    int size;
} ExamRoom;

ExamRoom* examRoomCreate(int n) {
    ExamRoom* obj = (ExamRoom*)malloc(sizeof(ExamRoom));
    obj->seats = (int*)malloc(n * sizeof(int));
    obj->capacity = n;
    obj->size = 0;
    return obj;
}

int examRoomSeat(ExamRoom* obj) {
    if (obj->size == 0) {
        obj->seats[0] = 0;
        obj->size = 1;
        return 0;
    }

    int maxDist = obj->seats[0];
    int pos = 0;

    for (int i = 0; i < obj->size - 1; i++) {
        int dist = (obj->seats[i + 1] - obj->seats[i]) / 2;
        if (dist > maxDist) {
            maxDist = dist;
            pos = obj->seats[i] + dist;
        }
    }

    int lastDist = obj->capacity - 1 - obj->seats[obj->size - 1];
    if (lastDist > maxDist) {
        pos = obj->capacity - 1;
        maxDist = lastDist;
    }

    int insertIndex = 0;
    while (insertIndex < obj->size && obj->seats[insertIndex] < pos) {
        insertIndex++;
    }

    for (int i = obj->size; i > insertIndex; i--) {
        obj->seats[i] = obj->seats[i - 1];
    }
    obj->seats[insertIndex] = pos;
    obj->size++;

    return pos;
}

void examRoomLeave(ExamRoom* obj, int p) {
    int index = -1;
    for (int i = 0; i < obj->size; i++) {
        if (obj->seats[i] == p) {
            index = i;
            break;
        }
    }

    if (index == -1) return;

    for (int i = index; i < obj->size - 1; i++) {
        obj->seats[i] = obj->seats[i + 1];
    }
    obj->size--;
}

void examRoomFree(ExamRoom* obj) {
    free(obj->seats);
    free(obj);
}