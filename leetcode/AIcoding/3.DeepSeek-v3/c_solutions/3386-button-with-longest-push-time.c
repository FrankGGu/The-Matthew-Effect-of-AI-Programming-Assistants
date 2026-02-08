typedef struct {
    char key;
    int time;
} Event;

char buttonWithLongestTime(char* keys, int keysSize, int* times, int timesSize) {
    Event events[keysSize];
    for (int i = 0; i < keysSize; i++) {
        events[i].key = keys[i];
        events[i].time = (i == 0) ? times[i] : times[i] - times[i-1];
    }

    char result = events[0].key;
    int max_time = events[0].time;

    for (int i = 1; i < keysSize; i++) {
        if (events[i].time > max_time) {
            max_time = events[i].time;
            result = events[i].key;
        } else if (events[i].time == max_time && events[i].key > result) {
            result = events[i].key;
        }
    }

    return result;
}