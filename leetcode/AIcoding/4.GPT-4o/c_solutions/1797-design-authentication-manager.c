#define HASH_SIZE 1000

typedef struct {
    int timeToLive;
    int timestamp;
    int count;
    struct User {
        int id;
        int expireTime;
    } users[HASH_SIZE];
} AuthenticationManager;

AuthenticationManager* authManagerCreate(int timeToLive) {
    AuthenticationManager* obj = (AuthenticationManager*)malloc(sizeof(AuthenticationManager));
    obj->timeToLive = timeToLive;
    obj->timestamp = 0;
    memset(obj->users, 0, sizeof(obj->users));
    return obj;
}

void authManagerGenerate(AuthenticationManager* obj, char* tokenId, int currentTime) {
    int id = atoi(tokenId) % HASH_SIZE;
    obj->users[id].id = atoi(tokenId);
    obj->users[id].expireTime = currentTime + obj->timeToLive;
}

void authManagerRenew(AuthenticationManager* obj, char* tokenId, int currentTime) {
    int id = atoi(tokenId) % HASH_SIZE;
    if (obj->users[id].id == atoi(tokenId) && obj->users[id].expireTime > currentTime) {
        obj->users[id].expireTime = currentTime + obj->timeToLive;
    }
}

int authManagerCountUnexpiredTokens(AuthenticationManager* obj, int currentTime) {
    int count = 0;
    for (int i = 0; i < HASH_SIZE; i++) {
        if (obj->users[i].expireTime > currentTime) {
            count++;
        }
    }
    return count;
}

void authManagerFree(AuthenticationManager* obj) {
    free(obj);
}