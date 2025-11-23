typedef struct {
    char **keys;
    int **timestamps;
    char **values;
    int *count;
    int size;
} TimeMap;

TimeMap* timeMapCreate() {
    TimeMap *tm = (TimeMap *)malloc(sizeof(TimeMap));
    tm->keys = (char **)malloc(10000 * sizeof(char *));
    tm->timestamps = (int **)malloc(10000 * sizeof(int *));
    tm->values = (char **)malloc(10000 * sizeof(char *));
    tm->count = (int *)malloc(10000 * sizeof(int));
    tm->size = 0;
    return tm;
}

void timeMapSet(TimeMap* obj, char* key, char* value, int timestamp) {
    int i;
    for (i = 0; i < obj->size; i++) {
        if (strcmp(obj->keys[i], key) == 0) {
            break;
        }
    }
    if (i == obj->size) {
        obj->keys[obj->size] = strdup(key);
        obj->count[obj->size] = 0;
        obj->size++;
    }
    obj->timestamps[i] = (int *)realloc(obj->timestamps[i], (obj->count[i] + 1) * sizeof(int));
    obj->values[i] = (char **)realloc(obj->values[i], (obj->count[i] + 1) * sizeof(char *));
    obj->timestamps[i][obj->count[i]] = timestamp;
    obj->values[i][obj->count[i]] = strdup(value);
    obj->count[i]++;
}

char* timeMapGet(TimeMap* obj, char* key, int timestamp) {
    int i;
    for (i = 0; i < obj->size; i++) {
        if (strcmp(obj->keys[i], key) == 0) {
            int left = 0, right = obj->count[i] - 1;
            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (obj->timestamps[i][mid] <= timestamp) {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
            if (right >= 0) {
                return obj->values[i][right];
            }
            return "";
        }
    }
    return "";
}

void timeMapFree(TimeMap* obj) {
    for (int i = 0; i < obj->size; i++) {
        free(obj->keys[i]);
        free(obj->timestamps[i]);
        free(obj->values[i]);
    }
    free(obj->keys);
    free(obj->timestamps);
    free(obj->values);
    free(obj->count);
    free(obj);
}