#include <stdlib.h>

typedef struct {
    int task_type;
    long long last_day;
} MapEntry;

#define HASH_TABLE_SIZE 200003

MapEntry* get_or_create_entry(MapEntry* map, int task_type) {
    unsigned int index = task_type % HASH_TABLE_SIZE;

    while (map[index].task_type != 0 && map[index].task_type != task_type) {
        index = (index + 1) % HASH_TABLE_SIZE;
    }

    if (map[index].task_type == 0) {
        map[index].task_type = task_type;
        map[index].last_day = 0;
    }
    return &map[index];
}

long long taskSchedulerII(int* tasks, int tasksSize, int space) {
    MapEntry* task_last_day_map = (MapEntry*)calloc(HASH_TABLE_SIZE, sizeof(MapEntry));
    if (task_last_day_map == NULL) {
        return -1;
    }

    long long current_day = 0;

    for (int i = 0; i < tasksSize; i++) {
        int current_task = tasks[i];
        current_day++;

        MapEntry* entry = get_or_create_entry(task_last_day_map, current_task);

        if (entry->last_day != 0) {
            long long earliest_next_day = entry->last_day + space + 1;
            if (current_day < earliest_next_day) {
                current_day = earliest_next_day;
            }
        }
        entry->last_day = current_day;
    }

    free(task_last_day_map);
    return current_day;
}