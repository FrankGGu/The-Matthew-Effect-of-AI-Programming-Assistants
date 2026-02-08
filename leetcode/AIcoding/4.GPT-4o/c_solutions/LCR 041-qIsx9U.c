typedef struct {
    double *window;
    int size;
    int count;
    double sum;
    int index;
} MovingAverage;

MovingAverage* movingAverageCreate(int size) {
    MovingAverage *ma = (MovingAverage *)malloc(sizeof(MovingAverage));
    ma->window = (double *)malloc(size * sizeof(double));
    ma->size = size;
    ma->count = 0;
    ma->sum = 0.0;
    ma->index = 0;
    return ma;
}

double movingAverageNext(MovingAverage* obj, int val) {
    if (obj->count < obj->size) {
        obj->count++;
    } else {
        obj->sum -= obj->window[obj->index];
    }
    obj->window[obj->index] = val;
    obj->sum += val;
    obj->index = (obj->index + 1) % obj->size;
    return obj->sum / obj->count;
}

void movingAverageFree(MovingAverage* obj) {
    free(obj->window);
    free(obj);
}