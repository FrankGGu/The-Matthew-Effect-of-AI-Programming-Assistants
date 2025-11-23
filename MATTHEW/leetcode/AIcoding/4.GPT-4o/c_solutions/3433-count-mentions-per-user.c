typedef struct {
    char* username;
    int count;
} UserCount;

int cmp(const void* a, const void* b) {
    return strcmp((*(UserCount**)a)->username, (*(UserCount**)b)->username);
}

char** countMentions(char** posts, int postsSize, int* returnSize) {
    UserCount* userCounts = malloc(100 * sizeof(UserCount));
    int userCountMap[100] = {0};
    int uniqueUsers = 0;

    for (int i = 0; i < postsSize; i++) {
        char* post = posts[i];
        char* token = strtok(post, " ");
        while (token) {
            if (token[0] == '@') {
                char* user = token + 1;
                int found = 0;
                for (int j = 0; j < uniqueUsers; j++) {
                    if (strcmp(userCounts[j].username, user) == 0) {
                        userCounts[j].count++;
                        found = 1;
                        break;
                    }
                }
                if (!found) {
                    userCounts[uniqueUsers].username = strdup(user);
                    userCounts[uniqueUsers].count = 1;
                    uniqueUsers++;
                }
            }
            token = strtok(NULL, " ");
        }
    }

    qsort(userCounts, uniqueUsers, sizeof(UserCount), cmp);

    char** result = malloc(uniqueUsers * sizeof(char*));
    for (int i = 0; i < uniqueUsers; i++) {
        char* res = malloc(100 * sizeof(char));
        sprintf(res, "%s %d", userCounts[i].username, userCounts[i].count);
        result[i] = res;
    }

    *returnSize = uniqueUsers;

    for (int i = 0; i < uniqueUsers; i++) {
        free(userCounts[i].username);
    }
    free(userCounts);

    return result;
}