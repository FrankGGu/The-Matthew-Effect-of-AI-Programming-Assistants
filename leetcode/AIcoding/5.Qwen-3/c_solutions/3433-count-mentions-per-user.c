#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* user;
    int count;
} UserMention;

typedef struct {
    UserMention* users;
    int size;
    int capacity;
} UserMentionList;

UserMentionList* create_user_mention_list() {
    UserMentionList* list = (UserMentionList*)malloc(sizeof(UserMentionList));
    list->size = 0;
    list->capacity = 4;
    list->users = (UserMention*)malloc(list->capacity * sizeof(UserMention));
    return list;
}

void add_user_mention(UserMentionList* list, const char* user) {
    for (int i = 0; i < list->size; i++) {
        if (strcmp(list->users[i].user, user) == 0) {
            list->users[i].count++;
            return;
        }
    }

    if (list->size >= list->capacity) {
        list->capacity *= 2;
        list->users = (UserMention*)realloc(list->users, list->capacity * sizeof(UserMention));
    }

    list->users[list->size].user = strdup(user);
    list->users[list->size].count = 1;
    list->size++;
}

void free_user_mention_list(UserMentionList* list) {
    for (int i = 0; i < list->size; i++) {
        free(list->users[i].user);
    }
    free(list->users);
    free(list);
}

int compare_users(const void* a, const void* b) {
    return strcmp(((UserMention*)a)->user, ((UserMention*)b)->user);
}

char** count_mentions_per_user(char** tweets, int tweetsSize, int* returnSize) {
    UserMentionList* mentionList = create_user_mention_list();

    for (int i = 0; i < tweetsSize; i++) {
        char* tweet = tweets[i];
        char* token = strtok(tweet, " ");
        while (token != NULL) {
            if (token[0] == '@') {
                char* user = token + 1;
                add_user_mention(mentionList, user);
            }
            token = strtok(NULL, " ");
        }
    }

    qsort(mentionList->users, mentionList->size, sizeof(UserMention), compare_users);

    *returnSize = mentionList->size;
    char** result = (char**)malloc(mentionList->size * sizeof(char*));

    for (int i = 0; i < mentionList->size; i++) {
        char* line = (char*)malloc(50 * sizeof(char));
        sprintf(line, "@%s: %d", mentionList->users[i].user, mentionList->users[i].count);
        result[i] = line;
    }

    free_user_mention_list(mentionList);
    return result;
}