#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* subscriptionType;
    int conversionCount;
} Subscription;

int* analyzeSubscriptionConversion(char** subscriptions, int subscriptionsSize, int* returnSize) {
    Subscription* subs = malloc(3 * sizeof(Subscription));
    subs[0].subscriptionType = "Basic";
    subs[0].conversionCount = 0;
    subs[1].subscriptionType = "Standard";
    subs[1].conversionCount = 0;
    subs[2].subscriptionType = "Premium";
    subs[2].conversionCount = 0;

    for (int i = 0; i < subscriptionsSize; i++) {
        if (strcmp(subscriptions[i], "Basic") == 0) {
            subs[0].conversionCount++;
        } else if (strcmp(subscriptions[i], "Standard") == 0) {
            subs[1].conversionCount++;
        } else if (strcmp(subscriptions[i], "Premium") == 0) {
            subs[2].conversionCount++;
        }
    }

    int* result = malloc(3 * sizeof(int));
    for (int i = 0; i < 3; i++) {
        result[i] = subs[i].conversionCount;
    }

    free(subs);
    *returnSize = 3;
    return result;
}