typedef struct {
    char** tokens;
    int* exp;
    int capacity;
    int size;
} AuthenticationManager;

AuthenticationManager* authenticationManagerCreate(int timeToLive) {
    AuthenticationManager* obj = (AuthenticationManager*)malloc(sizeof(AuthenticationManager));
    obj->capacity = 1000;
    obj->size = 0;
    obj->tokens = (char**)malloc(obj->capacity * sizeof(char*));
    obj->exp = (int*)malloc(obj->capacity * sizeof(int));
    return obj;
}

void authenticationManagerGenerate(AuthenticationManager* obj, char* tokenId, int currentTime) {
    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->tokens = (char**)realloc(obj->tokens, obj->capacity * sizeof(char*));
        obj->exp = (int*)realloc(obj->exp, obj->capacity * sizeof(int));
    }
    obj->tokens[obj->size] = (char*)malloc((strlen(tokenId) + 1) * sizeof(char));
    strcpy(obj->tokens[obj->size], tokenId);
    obj->exp[obj->size] = currentTime + obj->exp[0];
    obj->size++;
}

void authenticationManagerRenew(AuthenticationManager* obj, char* tokenId, int currentTime) {
    for (int i = 0; i < obj->size; i++) {
        if (strcmp(obj->tokens[i], tokenId) == 0) {
            if (obj->exp[i] > currentTime) {
                obj->exp[i] = currentTime + obj->exp[0];
            }
            return;
        }
    }
}

int authenticationManagerCountUnexpiredTokens(AuthenticationManager* obj, int currentTime) {
    int count = 0;
    for (int i = 0; i < obj->size; i++) {
        if (obj->exp[i] > currentTime) {
            count++;
        }
    }
    return count;
}

void authenticationManagerCleanup(AuthenticationManager* obj, int currentTime) {
    int newSize = 0;
    for (int i = 0; i < obj->size; i++) {
        if (obj->exp[i] > currentTime) {
            if (newSize != i) {
                free(obj->tokens[newSize]);
                obj->tokens[newSize] = obj->tokens[i];
                obj->exp[newSize] = obj->exp[i];
            }
            newSize++;
        } else {
            free(obj->tokens[i]);
        }
    }
    obj->size = newSize;
}

void authenticationManagerFree(AuthenticationManager* obj) {
    for (int i = 0; i < obj->size; i++) {
        free(obj->tokens[i]);
    }
    free(obj->tokens);
    free(obj->exp);
    free(obj);
}

/**
 * Your AuthenticationManager struct will be instantiated and called as such:
 * AuthenticationManager* obj = authenticationManagerCreate(timeToLive);
 * authenticationManagerGenerate(obj, tokenId, currentTime);
 * authenticationManagerRenew(obj, tokenId, currentTime);
 * int param_3 = authenticationManagerCountUnexpiredTokens(obj, currentTime);
 * authenticationManagerCleanup(obj, currentTime);
 * authenticationManagerFree(obj);
*/