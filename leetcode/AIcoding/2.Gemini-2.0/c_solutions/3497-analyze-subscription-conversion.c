#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char subscription_date[11];
    int customer_id;
} Subscription;

typedef struct {
    char conversion_date[11];
    int customer_id;
} Conversion;

typedef struct {
    char subscription_date[11];
    float conversion_rate;
} Result;

int compare_subscription(const void *a, const void *b) {
    return strcmp(((Subscription*)a)->subscription_date, ((Subscription*)b)->subscription_date);
}

int compare_conversion(const void *a, const void *b) {
    return strcmp(((Conversion*)a)->conversion_date, ((Conversion*)b)->conversion_date);
}

Result* analyze_subscription_conversion(Subscription* subscriptions, int subscriptionsSize, Conversion* conversions, int conversionsSize, int* returnSize) {
    qsort(subscriptions, subscriptionsSize, sizeof(Subscription), compare_subscription);
    qsort(conversions, conversionsSize, sizeof(Conversion), compare_conversion);

    Result* result = (Result*)malloc(subscriptionsSize * sizeof(Result));
    *returnSize = 0;

    int i = 0, j = 0;
    int converted_count = 0;
    char current_date[11] = "";

    while (i < subscriptionsSize) {
        if (strcmp(subscriptions[i].subscription_date, current_date) != 0) {
            if (*returnSize > 0) {
                result[*returnSize - 1].conversion_rate = (float)converted_count / (i - (i - converted_count));
            }

            strcpy(current_date, subscriptions[i].subscription_date);
            strcpy(result[*returnSize].subscription_date, current_date);
            converted_count = 0;
            *returnSize += 1;
        }

        while (j < conversionsSize && strcmp(conversions[j].conversion_date, subscriptions[i].subscription_date) <= 0) {
            if (strcmp(conversions[j].conversion_date, subscriptions[i].subscription_date) == 0) {
                converted_count++;
            }
            j++;
        }

        i++;
    }

    if (*returnSize > 0) {
        result[*returnSize - 1].conversion_rate = (float)converted_count / (i - (i - converted_count));
    }

    return result;
}