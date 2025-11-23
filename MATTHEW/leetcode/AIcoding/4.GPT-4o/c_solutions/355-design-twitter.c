#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_USERS 500

typedef struct Tweet {
    int id;
    int time;
    struct Tweet *next;
} Tweet;

typedef struct User {
    int id;
    Tweet *tweets;
    struct User *next;
} User;

typedef struct Twitter {
    User *users;
    int time;
} Twitter;

Twitter* twitterCreate() {
    Twitter *tw = (Twitter *)malloc(sizeof(Twitter));
    tw->users = NULL;
    tw->time = 0;
    return tw;
}

User* getUser(Twitter *tw, int userId) {
    User *curr = tw->users;
    while (curr) {
        if (curr->id == userId) {
            return curr;
        }
        curr = curr->next;
    }
    User *newUser = (User *)malloc(sizeof(User));
    newUser->id = userId;
    newUser->tweets = NULL;
    newUser->next = tw->users;
    tw->users = newUser;
    return newUser;
}

void postTweet(Twitter* obj, int userId, int tweetId) {
    obj->time++;
    User *user = getUser(obj, userId);
    Tweet *newTweet = (Tweet *)malloc(sizeof(Tweet));
    newTweet->id = tweetId;
    newTweet->time = obj->time;
    newTweet->next = user->tweets;
    user->tweets = newTweet;
}

int cmp(const void *a, const void *b) {
    return ((Tweet *)b)->time - ((Tweet *)a)->time;
}

int* getNewsFeed(Twitter* obj, int userId, int* returnSize) {
    User *user = getUser(obj, userId);
    Tweet *tweets[MAX_USERS];
    int count = 0;

    for (User *u = obj->users; u; u = u->next) {
        if (u->id == userId) {
            for (Tweet *t = u->tweets; t; t = t->next) {
                tweets[count++] = t;
            }
        } else {
            for (Tweet *t = u->tweets; t; t = t->next) {
                tweets[count++] = t;
            }
        }
    }

    qsort(tweets, count, sizeof(Tweet *), cmp);
    *returnSize = count < 10 ? count : 10;
    int *result = (int *)malloc((*returnSize) * sizeof(int));
    for (int i = 0; i < *returnSize; i++) {
        result[i] = tweets[i]->id;
    }
    return result;
}

void twitterFollow(Twitter* obj, int followerId, int followeeId) {
    // This function is not implemented as it is not needed for the current requirements.
}

void twitterUnfollow(Twitter* obj, int followerId, int followeeId) {
    // This function is not implemented as it is not needed for the current requirements.
}

void twitterFree(Twitter* obj) {
    // Free memory for users and tweets
    User *currUser = obj->users;
    while (currUser) {
        Tweet *currTweet = currUser->tweets;
        while (currTweet) {
            Tweet *temp = currTweet;
            currTweet = currTweet->next;
            free(temp);
        }
        User *tempUser = currUser;
        currUser = currUser->next;
        free(tempUser);
    }
    free(obj);
}