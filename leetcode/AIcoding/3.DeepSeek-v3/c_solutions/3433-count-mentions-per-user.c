typedef struct {
    char* name;
    int count;
    UT_hash_handle hh;
} User;

int cmp(const void* a, const void* b) {
    return strcmp(*(char**)a, *(char**)b);
}

char** findUsers(char** words, int wordsSize, int* returnSize) {
    char** users = malloc(wordsSize * sizeof(char*));
    *returnSize = 0;

    for (int i = 0; i < wordsSize; i++) {
        if (words[i][0] == '@') {
            users[(*returnSize)++] = words[i] + 1;
        }
    }

    if (*returnSize > 0) {
        qsort(users, *returnSize, sizeof(char*), cmp);

        int j = 0;
        for (int i = 1; i < *returnSize; i++) {
            if (strcmp(users[j], users[i]) != 0) {
                users[++j] = users[i];
            }
        }
        *returnSize = j + 1;
    }

    return users;
}

int* countMentions(int n, char*** messages, int messagesSize, int* messagesColSize, int* returnSize) {
    User* users = NULL;

    for (int i = 0; i < messagesSize; i++) {
        char** words = messages[i];
        int wordsSize = messagesColSize[i];

        int userCount;
        char** mentionedUsers = findUsers(words, wordsSize, &userCount);

        for (int j = 0; j < userCount; j++) {
            User* u = NULL;
            HASH_FIND_STR(users, mentionedUsers[j], u);
            if (u == NULL) {
                u = malloc(sizeof(User));
                u->name = mentionedUsers[j];
                u->count = 0;
                HASH_ADD_KEYPTR(hh, users, u->name, strlen(u->name), u);
            }
            u->count++;
        }
        free(mentionedUsers);
    }

    int* result = calloc(n, sizeof(int));
    *returnSize = n;

    User *current_user, *tmp;
    HASH_ITER(hh, users, current_user, tmp) {
        int userId = atoi(current_user->name);
        if (userId >= 1 && userId <= n) {
            result[userId - 1] = current_user->count;
        }
        HASH_DEL(users, current_user);
        free(current_user);
    }

    return result;
}