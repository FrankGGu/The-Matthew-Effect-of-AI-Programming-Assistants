#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char tokenId[41];
    int expiryTime;
} AuthToken;

typedef struct {
    AuthToken* tokens;
    int capacity;
    int size;
    int timeToLive;
} AuthenticationManager;

AuthenticationManager* authenticationManagerCreate(int timeToLive) {
    AuthenticationManager* obj = (AuthenticationManager*)malloc(sizeof(AuthenticationManager));
    obj->tokens = (AuthToken*)malloc(sizeof(AuthToken) * 1000);
    obj->capacity = 1000;
    obj->size = 0;
    obj->timeToLive = timeToLive;
    return obj;
}

void authenticationManagerGenerate(AuthenticationManager* obj, char * tokenId, int currentTime) {

    for(int i = 0; i < obj->size; i++){
        if(strcmp(obj->tokens[i].tokenId, tokenId) == 0){
            obj->tokens[i].expiryTime = currentTime + obj->timeToLive;
            return;
        }
    }

    if(obj->size == obj->capacity){
        obj->capacity *= 2;
        obj->tokens = (AuthToken*)realloc(obj->tokens, sizeof(AuthToken) * obj->capacity);
    }

    strcpy(obj->tokens[obj->size].tokenId, tokenId);
    obj->tokens[obj->size].expiryTime = currentTime + obj->timeToLive;
    obj->size++;

}

void authenticationManagerRenew(AuthenticationManager* obj, char * tokenId, int currentTime) {
    for (int i = 0; i < obj->size; i++) {
        if (strcmp(obj->tokens[i].tokenId, tokenId) == 0) {
            if (obj->tokens[i].expiryTime > currentTime) {
                obj->tokens[i].expiryTime = currentTime + obj->timeToLive;
            }
            return;
        }
    }
}

int authenticationManagerCountUnexpiredTokens(AuthenticationManager* obj, int currentTime) {
    int count = 0;
    for (int i = 0; i < obj->size; i++) {
        if (obj->tokens[i].expiryTime > currentTime) {
            count++;
        }
    }
    return count;
}

void authenticationManagerFree(AuthenticationManager* obj) {
    free(obj->tokens);
    free(obj);
}