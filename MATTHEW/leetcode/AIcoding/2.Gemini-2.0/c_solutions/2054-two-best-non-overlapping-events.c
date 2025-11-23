#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return ((int*)a)[1] - ((int*)b)[1];
}

int max(int a, int b) {
    return (a > b) ? a : b;
}

int maxTwoEvents(int events[][3], int eventsSize, int* eventsColSize){
    qsort(events, eventsSize, sizeof(events[0]), cmp);
    int dp[eventsSize];
    dp[0] = events[0][2];
    for (int i = 1; i < eventsSize; i++) {
        dp[i] = events[i][2];
        for (int j = 0; j < i; j++) {
            if (events[j][1] < events[i][0]) {
                dp[i] = max(dp[i], events[i][2] + dp[j]);
            }
        }
        dp[i] = max(dp[i], dp[i - 1]);
    }

    int ans = events[0][2];
    for(int i = 1; i < eventsSize; i++){
        ans = max(ans, events[i][2]);
    }

    for (int i = 0; i < eventsSize; i++) {
        int max_val = 0;
        for (int j = 0; j < eventsSize; j++) {
            if (events[i][1] < events[j][0]) {
                max_val = max(max_val, events[i][2] + events[j][2]);
            }
        }
        ans = max(ans, max_val);
    }

    int max1 = 0;
    for(int i = 0; i < eventsSize; i++){
        max1 = max(max1, events[i][2]);
    }

    int max2 = 0;
    for(int i = 0; i < eventsSize; i++){
        for(int j = i + 1; j < eventsSize; j++){
            if(events[i][1] < events[j][0]){
                max2 = max(max2, events[i][2] + events[j][2]);
            }
        }
    }

    if(max2 == 0){
        return max1;
    }

    int prefix_max[eventsSize];
    prefix_max[0] = events[0][2];
    for(int i = 1; i < eventsSize; i++){
        prefix_max[i] = max(prefix_max[i - 1], events[i][2]);
    }

    int result = 0;
    for(int i = 0; i < eventsSize; i++){
        int current_val = events[i][2];
        int max_before = 0;
        for(int j = 0; j < i; j++){
            if(events[j][1] < events[i][0]){
                max_before = max(max_before, events[j][2]);
            }
        }

        int max_after = 0;
        for(int j = i + 1; j < eventsSize; j++){
            if(events[i][1] < events[j][0]){
                max_after = max(max_after, events[j][2]);
            }
        }

        result = max(result, current_val + max_before);
        result = max(result, current_val + max_after);
    }

    int max_sum = 0;
    for(int i = 0; i < eventsSize; i++){
        for(int j = i + 1; j < eventsSize; j++){
            if(events[i][1] < events[j][0]){
                max_sum = max(max_sum, events[i][2] + events[j][2]);
            }
        }
    }
    if(max_sum == 0){
        return max1;
    }

    return max(max1, max_sum);
}