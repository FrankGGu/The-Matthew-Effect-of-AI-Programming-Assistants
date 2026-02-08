/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
typedef struct {
    char name[11];
    int time;
    int amount;
    char city[11];
    int index;
} Transaction;

int cmp(const void* a, const void* b) {
    Transaction* t1 = (Transaction*)a;
    Transaction* t2 = (Transaction*)b;
    int name_cmp = strcmp(t1->name, t2->name);
    if (name_cmp != 0) return name_cmp;
    return t1->time - t2->time;
}

char** invalidTransactions(char** transactions, int transactionsSize, int* returnSize) {
    Transaction* trans = (Transaction*)malloc(transactionsSize * sizeof(Transaction));
    for (int i = 0; i < transactionsSize; i++) {
        char* token = strtok(transactions[i], ",");
        strcpy(trans[i].name, token);

        token = strtok(NULL, ",");
        trans[i].time = atoi(token);

        token = strtok(NULL, ",");
        trans[i].amount = atoi(token);

        token = strtok(NULL, ",");
        strcpy(trans[i].city, token);

        trans[i].index = i;
    }

    qsort(trans, transactionsSize, sizeof(Transaction), cmp);

    bool* invalid = (bool*)calloc(transactionsSize, sizeof(bool));

    for (int i = 0; i < transactionsSize; i++) {
        if (trans[i].amount > 1000) {
            invalid[trans[i].index] = true;
        }

        int j = i + 1;
        while (j < transactionsSize && strcmp(trans[i].name, trans[j].name) == 0) {
            if (trans[j].time - trans[i].time <= 60 && strcmp(trans[i].city, trans[j].city) != 0) {
                invalid[trans[i].index] = true;
                invalid[trans[j].index] = true;
            }
            j++;
        }

        j = i - 1;
        while (j >= 0 && strcmp(trans[i].name, trans[j].name) == 0) {
            if (trans[i].time - trans[j].time <= 60 && strcmp(trans[i].city, trans[j].city) != 0) {
                invalid[trans[i].index] = true;
                invalid[trans[j].index] = true;
            }
            j--;
        }
    }

    int count = 0;
    for (int i = 0; i < transactionsSize; i++) {
        if (invalid[i]) count++;
    }

    char** result = (char**)malloc(count * sizeof(char*));
    int idx = 0;
    for (int i = 0; i < transactionsSize; i++) {
        if (invalid[i]) {
            result[idx++] = transactions[i];
        }
    }

    *returnSize = count;
    free(trans);
    free(invalid);
    return result;
}