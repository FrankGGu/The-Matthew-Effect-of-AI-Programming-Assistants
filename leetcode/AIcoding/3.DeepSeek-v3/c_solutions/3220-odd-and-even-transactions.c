#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char transaction_id[20];
    int amount;
    char state[10];
    char date[20];
} Transaction;

typedef struct {
    char date[20];
    int total_amount;
    int transaction_count;
} DailySummary;

int compareDates(const char* date1, const char* date2) {
    return strcmp(date1, date2);
}

char** findTransactions(int transactions_rows, char** transactions_data, int* returnSize) {
    Transaction* transactions = malloc(transactions_rows * sizeof(Transaction));

    for (int i = 0; i < transactions_rows; i++) {
        char* token = strtok(transactions_data[i], ",");
        strcpy(transactions[i].transaction_id, token);

        token = strtok(NULL, ",");
        transactions[i].amount = atoi(token);

        token = strtok(NULL, ",");
        strcpy(transactions[i].state, token);

        token = strtok(NULL, ",");
        strcpy(transactions[i].date, token);
    }

    DailySummary* summaries = malloc(transactions_rows * sizeof(DailySummary));
    int summary_count = 0;

    for (int i = 0; i < transactions_rows; i++) {
        if (strcmp(transactions[i].state, "approved") != 0) {
            continue;
        }

        int found = 0;
        for (int j = 0; j < summary_count; j++) {
            if (compareDates(summaries[j].date, transactions[i].date) == 0) {
                summaries[j].total_amount += transactions[i].amount;
                summaries[j].transaction_count++;
                found = 1;
                break;
            }
        }

        if (!found) {
            strcpy(summaries[summary_count].date, transactions[i].date);
            summaries[summary_count].total_amount = transactions[i].amount;
            summaries[summary_count].transaction_count = 1;
            summary_count++;
        }
    }

    char** result = malloc(summary_count * sizeof(char*));
    *returnSize = summary_count;

    for (int i = 0; i < summary_count; i++) {
        if (summaries[i].transaction_count % 2 == 1) {
            result[i] = malloc(50 * sizeof(char));
            sprintf(result[i], "%s,%d", summaries[i].date, summaries[i].total_amount);
        } else {
            result[i] = malloc(50 * sizeof(char));
            sprintf(result[i], "%s,%d", summaries[i].date, 0);
        }
    }

    free(transactions);
    free(summaries);

    return result;
}