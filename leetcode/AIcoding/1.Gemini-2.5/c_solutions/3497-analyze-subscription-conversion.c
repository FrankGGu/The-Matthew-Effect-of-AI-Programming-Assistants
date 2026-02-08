#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <stdbool.h>

typedef struct {
    int user_id;
    char subscribe_date[11]; // "YYYY-MM-DD"
    char convert_date[11];   // "YYYY-MM-DD" or empty string "" if not converted
} RawSubscription;

typedef struct {
    int user_id;
    int subscribe_year;
    int subscribe_month;
    bool converted;
} ProcessedSubscription;

typedef struct {
    int year;
    int month;
    int total_subscriptions;
    int converted_subscriptions;
} ConversionResult;

static void parseDate(const char* dateStr, int* year, int* month) {
    if (dateStr == NULL || strlen(dateStr) < 7) {
        *year = 0;
        *month = 0;
        return;
    }
    sscanf(dateStr, "%d-%d", year, month);
}

static int compareProcessedSubscriptions(const void* a, const void* b) {
    ProcessedSubscription* subA = (ProcessedSubscription*)a;
    ProcessedSubscription* subB = (ProcessedSubscription*)b;

    if (subA->subscribe_year != subB->subscribe_year) {
        return subA->subscribe_year - subB->subscribe_year;
    }
    return subA->subscribe_month - subB->subscribe_month;
}

ConversionResult* analyzeSubscriptionConversion(RawSubscription* subscriptions, int subscriptionsSize, int* returnSize) {
    if (subscriptions == NULL || subscriptionsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    ProcessedSubscription* processedSubs = (ProcessedSubscription*)malloc(subscriptionsSize * sizeof(ProcessedSubscription));
    if (processedSubs == NULL) {
        *returnSize = 0;
        return NULL;
    }

    for (int i = 0; i < subscriptionsSize; ++i) {
        processedSubs[i].user_id = subscriptions[i].user_id;
        parseDate(subscriptions[i].subscribe_date, &processedSubs[i].subscribe_year, &processedSubs[i].subscribe_month);

        if (strlen(subscriptions[i].convert_date) > 0) {
            processedSubs[i].converted = true;
        } else {
            processedSubs[i].converted = false;
        }
    }

    qsort(processedSubs, subscriptionsSize, sizeof(ProcessedSubscription), compareProcessedSubscriptions);

    ConversionResult* results = NULL;
    int currentResultCapacity = 0;
    int currentResultSize = 0;

    for (int i = 0; i < subscriptionsSize; ) {
        int currentYear = processedSubs[i].subscribe_year;
        int currentMonth = processedSubs[i].subscribe_month;
        int totalSubscriptionsInMonth = 0;
        int convertedSubscriptionsInMonth = 0;

        int j = i;
        while (j < subscriptionsSize && 
               processedSubs[j].subscribe_year == currentYear &&
               processedSubs[j].subscribe_month == currentMonth) {
            totalSubscriptionsInMonth++;
            if (processedSubs[j].converted) {
                convertedSubscriptionsInMonth++;
            }
            j++;
        }

        if (currentResultSize == currentResultCapacity) {
            currentResultCapacity = (currentResultCapacity == 0) ? 4 : currentResultCapacity * 2;
            ConversionResult* newResults = (ConversionResult*)realloc(results, currentResultCapacity * sizeof(ConversionResult));
            if (newResults == NULL) {
                free(processedSubs);
                free(results);
                *returnSize = 0;
                return NULL;
            }
            results = newResults;
        }

        results[currentResultSize].year = currentYear;
        results[currentResultSize].month = currentMonth;
        results[currentResultSize].total_subscriptions = totalSubscriptionsInMonth;
        results[currentResultSize].converted_subscriptions = convertedSubscriptionsInMonth;
        currentResultSize++;

        i = j;
    }

    free(processedSubs);

    *returnSize = currentResultSize;
    return results;
}