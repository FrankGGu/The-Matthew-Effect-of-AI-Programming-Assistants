typedef struct {
    int *window;
    int size;
    int count;
    int sum;
    int insertIndex;
} MovingAverage;

MovingAverage* movingAverageCreate(int size) {
    MovingAverage *obj = (MovingAverage*)malloc(sizeof(MovingAverage));
    obj->window = (int*)malloc(size * sizeof(int));
    obj->size = size;
    obj->count = 0;
    obj->sum = 0;
    obj->insertIndex = 0;
    return obj;
}

double movingAverageNext(MovingAverage* obj, int val) {
    if (obj->count < obj->size) {
        obj->sum += val;
        obj->window[obj->insertIndex] = val;
        obj->insertIndex = (obj->insertIndex + 1) % obj->size;
        obj->count++;
        return (double)obj->sum / obj->count;
    } else {
        obj->sum -= obj->window[obj->insertIndex];
        obj->sum += val;
        obj->window[obj->insertIndex] = val;
        obj->insertIndex = (obj->insertIndex + 1) % obj->size;
        return (double)obj->sum / obj->size;
    }
}

void movingAverageFree(MovingAverage* obj) {
    free(obj->window);
    free(obj);
}