#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Tweet {
    int tweetId;
    int userId;
    int time;
    struct Tweet* next;
} Tweet;

typedef struct User {
    int userId;
    Tweet* head;
    int* followees;
    int followeesSize;
} User;

typedef struct Twitter {
    User* users;
    int usersSize;
    int time;
} Twitter;

Twitter* twitterCreate() {
    Twitter* obj = (Twitter*)malloc(sizeof(Twitter));
    obj->users = NULL;
    obj->usersSize = 0;
    obj->time = 0;
    return obj;
}

void twitterPostTweet(Twitter* obj, int userId, int tweetId) {
    obj->time++;
    Tweet* newTweet = (Tweet*)malloc(sizeof(Tweet));
    newTweet->tweetId = tweetId;
    newTweet->userId = userId;
    newTweet->time = obj->time;
    newTweet->next = NULL;

    User* user = NULL;
    for (int i = 0; i < obj->usersSize; i++) {
        if (obj->users[i].userId == userId) {
            user = &obj->users[i];
            break;
        }
    }

    if (user == NULL) {
        obj->usersSize++;
        obj->users = (User*)realloc(obj->users, obj->usersSize * sizeof(User));
        user = &obj->users[obj->usersSize - 1];
        user->userId = userId;
        user->head = NULL;
        user->followees = (int*)malloc(sizeof(int));
        user->followees[0] = userId;
        user->followeesSize = 1;
    }

    newTweet->next = user->head;
    user->head = newTweet;
}

int* twitterGetNewsFeed(Twitter* obj, int userId, int* returnSize) {
    User* user = NULL;
    for (int i = 0; i < obj->usersSize; i++) {
        if (obj->users[i].userId == userId) {
            user = &obj->users[i];
            break;
        }
    }

    if (user == NULL) {
        *returnSize = 0;
        return NULL;
    }

    Tweet* feedTweets[10] = {NULL};
    int feedSize = 0;

    for (int i = 0; i < user->followeesSize; i++) {
        int followeeId = user->followees[i];
        User* followee = NULL;
        for (int j = 0; j < obj->usersSize; j++) {
            if (obj->users[j].userId == followeeId) {
                followee = &obj->users[j];
                break;
            }
        }

        if (followee != NULL) {
            Tweet* current = followee->head;
            while (current != NULL && feedSize < 10) {
                int inserted = 0;
                for (int k = 0; k < feedSize; k++) {
                    if (current->time > feedTweets[k]->time) {
                        for (int l = feedSize; l > k; l--) {
                            feedTweets[l] = feedTweets[l - 1];
                        }
                        feedTweets[k] = current;
                        inserted = 1;
                        if (feedSize < 10) feedSize++;
                        break;
                    }
                }
                if (!inserted && feedSize < 10) {
                    feedTweets[feedSize] = current;
                    feedSize++;
                }
                current = current->next;
            }
        }
    }

    int* result = (int*)malloc(feedSize * sizeof(int));
    for (int i = 0; i < feedSize; i++) {
        result[i] = feedTweets[i]->tweetId;
    }

    *returnSize = feedSize;
    return result;
}

void twitterFollow(Twitter* obj, int followerId, int followeeId) {
    User* user = NULL;
    for (int i = 0; i < obj->usersSize; i++) {
        if (obj->users[i].userId == followerId) {
            user = &obj->users[i];
            break;
        }
    }

    if (user == NULL) {
        obj->usersSize++;
        obj->users = (User*)realloc(obj->users, obj->usersSize * sizeof(User));
        user = &obj->users[obj->usersSize - 1];
        user->userId = followerId;
        user->head = NULL;
        user->followees = (int*)malloc(sizeof(int));
        user->followees[0] = followerId;
        user->followeesSize = 1;
    }

    for (int i = 0; i < user->followeesSize; i++) {
        if (user->followees[i] == followeeId) {
            return;
        }
    }

    user->followeesSize++;
    user->followees = (int*)realloc(user->followees, user->followeesSize * sizeof(int));
    user->followees[user->followeesSize - 1] = followeeId;
}

void twitterUnfollow(Twitter* obj, int followerId, int followeeId) {
    User* user = NULL;
    for (int i = 0; i < obj->usersSize; i++) {
        if (obj->users[i].userId == followerId) {
            user = &obj->users[i];
            break;
        }
    }

    if (user == NULL || followerId == followeeId) {
        return;
    }

    int indexToRemove = -1;
    for (int i = 0; i < user->followeesSize; i++) {
        if (user->followees[i] == followeeId) {
            indexToRemove = i;
            break;
        }
    }

    if (indexToRemove != -1) {
        for (int i = indexToRemove; i < user->followeesSize - 1; i++) {
            user->followees[i] = user->followees[i + 1];
        }
        user->followeesSize--;
        user->followees = (int*)realloc(user->followees, user->followeesSize * sizeof(int));
    }
}

void twitterFree(Twitter* obj) {
    if (obj) {
        if (obj->users) {
            for (int i = 0; i < obj->usersSize; i++) {
                Tweet* current = obj->users[i].head;
                while (current) {
                    Tweet* temp = current;
                    current = current->next;
                    free(temp);
                }
                free(obj->users[i].followees);
            }
            free(obj->users);
        }
        free(obj);
    }
}