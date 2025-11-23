#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* analyzeSubscriptionConversion(char* events) {
    int freeTrial = 0;
    int premium = 0;
    int freeTrialToPremium = 0;
    int totalFreeTrial = 0;

    char* token = strtok(events, " ");
    while (token != NULL) {
        if (strcmp(token, "START_FREE_TRIAL") == 0) {
            freeTrial++;
            totalFreeTrial++;
        } else if (strcmp(token, "END_FREE_TRIAL") == 0) {
            if (freeTrial > 0) {
                freeTrial--;
            }
        } else if (strcmp(token, "CONVERT_TO_PREMIUM") == 0) {
            if (freeTrial > 0) {
                freeTrial--;
                freeTrialToPremium++;
            }
            premium++;
        } else if (strcmp(token, "CANCEL_PREMIUM") == 0) {
            if (premium > 0) {
                premium--;
            }
        }
        token = strtok(NULL, " ");
    }

    char* result = malloc(50 * sizeof(char));
    if (totalFreeTrial == 0) {
        sprintf(result, "0.00%%");
    } else {
        double rate = (double)freeTrialToPremium / totalFreeTrial * 100;
        sprintf(result, "%.2f%%", rate);
    }

    return result;
}