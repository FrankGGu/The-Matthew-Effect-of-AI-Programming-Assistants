#include <stdlib.h>
#include <string.h>

typedef struct {
    int user_id;
    int post_id;
    char action[10];
    char extra[10];
} Action;

int* reportSpamMessage(Action* actions, int actionsSize, int* returnSize) {
    int* temp_post_ids = (int*)malloc(sizeof(int) * actionsSize);
    int current_count = 0;

    for (int i = 0; i < actionsSize; i++) {
        if (strcmp(actions[i].action, "report") == 0 && strcmp(actions[i].extra, "spam") == 0) {
            temp_post_ids[current_count++] = actions[i].post_id;
        }
    }

    int* distinct_post_ids = (int*)malloc(sizeof(int) * current_count);
    int distinct_count = 0;

    for (int i = 0; i < current_count; i++) {
        int is_duplicate = 0;
        for (int j = 0; j < distinct_count; j++) {
            if (distinct_post_ids[j] == temp_post_ids[i]) {
                is_duplicate = 1;
                break;
            }
        }
        if (!is_duplicate) {
            distinct_post_ids[distinct_count++] = temp_post_ids[i];
        }
    }

    free(temp_post_ids);

    *returnSize = distinct_count;
    if (distinct_count == 0) {
        free(distinct_post_ids);
        return NULL;
    }
    return (int*)realloc(distinct_post_ids, sizeof(int) * distinct_count);
}