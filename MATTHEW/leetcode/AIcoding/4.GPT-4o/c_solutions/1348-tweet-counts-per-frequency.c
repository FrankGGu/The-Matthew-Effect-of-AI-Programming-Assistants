#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define MAX_TWEETS 10000
#define MAX_FREQUENCY 4

struct Tweet {
    int time;
    struct Tweet* next;
};

struct TweetCount {
    struct Tweet* head;
};

struct TweetCount* createTweetCount() {
    struct TweetCount* tc = (struct TweetCount*)malloc(sizeof(struct TweetCount));
    tc->head = NULL;
    return tc;
}

void addTweet(struct TweetCount* tc, int time) {
    struct Tweet* newTweet = (struct Tweet*)malloc(sizeof(struct Tweet));
    newTweet->time = time;
    newTweet->next = tc->head;
    tc->head = newTweet;
}

int countTweets(struct TweetCount* tc, int startTime, int endTime) {
    int count = 0;
    struct Tweet* current = tc->head;
    while (current) {
        if (current->time >= startTime && current->time <= endTime) {
            count++;
        }
        current = current->next;
    }
    return count;
}

struct TweetCounts {
    struct TweetCount* counts[MAX_FREQUENCY];
};

struct TweetCounts* tweetCountsCreate() {
    struct TweetCounts* tc = (struct TweetCounts*)malloc(sizeof(struct TweetCounts));
    for (int i = 0; i < MAX_FREQUENCY; i++) {
        tc->counts[i] = createTweetCount();
    }
    return tc;
}

void tweetCountsRecord(struct TweetCounts* obj, char* tweetName, int time) {
    addTweet(obj->counts[0], time);
}

int* tweetCountsGetTweetCountsPerFrequency(struct TweetCounts* obj, char* tweetName, char* freq, int* returnSize) {
    int frequency = 0;
    if (strcmp(freq, "minute") == 0) frequency = 0;
    else if (strcmp(freq, "hour") == 0) frequency = 1;
    else if (strcmp(freq, "day") == 0) frequency = 2;

    int* result = (int*)malloc(sizeof(int) * 60);
    memset(result, 0, sizeof(int) * 60);

    struct TweetCount* tc = obj->counts[frequency];
    for (int i = 0; i < 60; i++) {
        result[i] = countTweets(tc, i * (frequency == 0 ? 60 : (frequency == 1 ? 3600 : 86400)), (i + 1) * (frequency == 0 ? 60 : (frequency == 1 ? 3600 : 86400)) - 1);
    }

    *returnSize = 60;
    return result;
}

void tweetCountsFree(struct TweetCounts* obj) {
    for (int i = 0; i < MAX_FREQUENCY; i++) {
        struct Tweet* current = obj->counts[i]->head;
        while (current) {
            struct Tweet* temp = current;
            current = current->next;
            free(temp);
        }
        free(obj->counts[i]);
    }
    free(obj);
}