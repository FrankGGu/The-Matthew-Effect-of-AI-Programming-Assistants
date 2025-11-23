typedef struct {
    char** message;
    int messageSize;
    char** bannedWords;
    int bannedWordsSize;
} ChatFilter;

ChatFilter* chatFilterCreate(char** bannedWords, int bannedWordsSize) {
    ChatFilter* obj = (ChatFilter*)malloc(sizeof(ChatFilter));
    obj->bannedWords = bannedWords;
    obj->bannedWordsSize = bannedWordsSize;
    return obj;
}

bool containsBannedWord(char* word, char** bannedWords, int bannedWordsSize) {
    for (int i = 0; i < bannedWordsSize; i++) {
        if (strcmp(word, bannedWords[i]) == 0) {
            return true;
        }
    }
    return false;
}

bool chatFilterFilter(ChatFilter* obj, char* message) {
    char* copy = strdup(message);
    char* token = strtok(copy, " ");
    bool found = false;

    while (token != NULL) {
        if (containsBannedWord(token, obj->bannedWords, obj->bannedWordsSize)) {
            found = true;
            break;
        }
        token = strtok(NULL, " ");
    }

    free(copy);
    return found;
}

void chatFilterFree(ChatFilter* obj) {
    free(obj);
}