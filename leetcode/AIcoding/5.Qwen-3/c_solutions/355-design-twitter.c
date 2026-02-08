#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

typedef struct Tweet {
    int tweetId;
    int userId;
    long timestamp;
    struct Tweet* next;
} Tweet;

typedef struct User {
    int userId;
    Tweet* tweets;
    struct User** followers;
    int followerCount;
} User;

typedef struct {
    User** users;
    int userCount;
    long time;
} Twitter;

Tweet* createTweet(int tweetId, int userId, long timestamp) {
    Tweet* newTweet = (Tweet*)malloc(sizeof(Tweet));
    newTweet->tweetId = tweetId;
    newTweet->userId = userId;
    newTweet->timestamp = timestamp;
    newTweet->next = NULL;
    return newTweet;
}

User* createUser(int userId) {
    User* newUser = (User*)malloc(sizeof(User));
    newUser->userId = userId;
    newUser->tweets = NULL;
    newUser->followers = (User**)malloc(sizeof(User*));
    newUser->followerCount = 0;
    return newUser;
}

void follow(User* follower, User* followee) {
    for (int i = 0; i < follower->followerCount; i++) {
        if (follower->followers[i] == followee) return;
    }
    follower->followers = (User**)realloc(follower->followers, sizeof(User*) * (follower->followerCount + 1));
    follower->followers[follower->followerCount++] = followee;
}

void unfollow(User* follower, User* followee) {
    for (int i = 0; i < follower->followerCount; i++) {
        if (follower->followers[i] == followee) {
            for (int j = i; j < follower->followerCount - 1; j++) {
                follower->followers[j] = follower->followers[j + 1];
            }
            follower->followers = (User**)realloc(follower->followers, sizeof(User*) * (follower->followerCount - 1));
            follower->followerCount--;
            return;
        }
    }
}

void postTweet(Twitter* twitter, int userId, int tweetId) {
    User* user = NULL;
    for (int i = 0; i < twitter->userCount; i++) {
        if (twitter->users[i]->userId == userId) {
            user = twitter->users[i];
            break;
        }
    }
    if (!user) {
        user = createUser(userId);
        twitter->users = (User**)realloc(twitter->users, sizeof(User*) * (twitter->userCount + 1));
        twitter->users[twitter->userCount++] = user;
    }
    Tweet* newTweet = createTweet(tweetId, userId, twitter->time++);
    newTweet->next = user->tweets;
    user->tweets = newTweet;
}

void getNewsFeed(Twitter* twitter, int userId, int* result, int* returnSize) {
    User* user = NULL;
    for (int i = 0; i < twitter->userCount; i++) {
        if (twitter->users[i]->userId == userId) {
            user = twitter->users[i];
            break;
        }
    }
    if (!user) {
        *returnSize = 0;
        return;
    }
    Tweet* temp = user->tweets;
    int count = 0;
    while (temp && count < 10) {
        result[count++] = temp->tweetId;
        temp = temp->next;
    }
    for (int i = 0; i < user->followerCount; i++) {
        User* follower = user->followers[i];
        Tweet* t = follower->tweets;
        while (t && count < 10) {
            result[count++] = t->tweetId;
            t = t->next;
        }
    }
    *returnSize = count;
}

Twitter* twitterCreate() {
    Twitter* twitter = (Twitter*)malloc(sizeof(Twitter));
    twitter->users = (User**)malloc(0);
    twitter->userCount = 0;
    twitter->time = 0;
    return twitter;
}

void twitterFree(Twitter* twitter) {
    for (int i = 0; i < twitter->userCount; i++) {
        User* user = twitter->users[i];
        Tweet* t = user->tweets;
        while (t) {
            Tweet* next = t->next;
            free(t);
            t = next;
        }
        free(user->followers);
        free(user);
    }
    free(twitter->users);
    free(twitter);
}