#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char user_id[10];
    char event_date[11];
    char event_type[10];
} Events;

typedef struct {
    char user_id[10];
    char subscription_date[11];
} Subscriptions;

double conversion_rate(Events* events, int eventsSize, Subscriptions* subscriptions, int subscriptionsSize) {
    int total_users = 0;
    int converted_users = 0;

    for (int i = 0; i < subscriptionsSize; i++) {
        total_users++;
        int has_paid_event = 0;
        for (int j = 0; j < eventsSize; j++) {
            if (strcmp(events[j].user_id, subscriptions[i].user_id) == 0 && strcmp(events[j].event_type, "paid_subscribe") == 0) {
                has_paid_event = 1;
                break;
            }
        }
        if (has_paid_event) {
            converted_users++;
        }
    }

    if (total_users == 0) return 0.0;
    return (double)converted_users / total_users;
}