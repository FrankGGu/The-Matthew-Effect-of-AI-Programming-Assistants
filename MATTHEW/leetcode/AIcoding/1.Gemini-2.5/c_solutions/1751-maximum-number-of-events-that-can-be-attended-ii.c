#include <stdlib.h>
#include <string.h>

typedef struct {
    int startDay;
    int endDay;
    int value;
} Event;

int compareEvents(const void* a, const void* b) {
    Event* eventA = (Event*)a;
    Event* eventB = (Event*)b;
    if (eventA->startDay != eventB->startDay) {
        return eventA->startDay - eventB->startDay;
    }
    return eventA->endDay - eventB->endDay;
}

int findNextEvent(Event* events, int numEvents, int currentEndDay, int startIndex) {
    int low = startIndex;
    int high = numEvents - 1;
    int result = numEvents;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (events[mid].startDay > currentEndDay) {
            result = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return result;
}

int maxValue(int** eventsData, int eventsSize, int* eventsColSize, int k) {
    int numEvents = eventsSize;

    Event* events = (Event*)malloc(numEvents * sizeof(Event));
    if (!events) return 0;

    for (int i = 0; i < numEvents; i++) {
        events[i].startDay = eventsData[i][0];
        events[i].endDay = eventsData[i][1];
        events[i].value = eventsData[i][2];
    }

    qsort(events, numEvents, sizeof(Event), compareEvents);

    int** dp = (int**)malloc((numEvents + 1) * sizeof(int*));
    if (!dp) {
        free(events);
        return 0;
    }
    for (int i = 0; i <= numEvents; i++) {
        dp[i] = (int*)malloc((k + 1) * sizeof(int));
        if (!dp[i]) {
            for (int j = 0; j < i; j++) free(dp[j]);
            free(dp);
            free(events);
            return 0;
        }
        memset(dp[i], 0, (k + 1) * sizeof(int));
    }

    for (int i = numEvents - 1; i >= 0; i--) {
        for (int j = 1; j <= k; j++) {
            int val1 = dp[i + 1][j];

            int nextEventIdx = findNextEvent(events, numEvents, events[i].endDay, i + 1);

            int val2 = events[i].value;
            val2 += dp[nextEventIdx][j - 1];

            dp[i][j] = (val1 > val2) ? val1 : val2;
        }
    }

    int result = dp[0][k];

    for (int i = 0; i <= numEvents; i++) {
        free(dp[i]);
    }
    free(dp);
    free(events);

    return result;
}