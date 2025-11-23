#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct {
    int id;
    char name[50];
    double score;
} Record;

void printRecordWithRenamedColumn(const Record* rec) {
    printf("customer_id: %d, name: %s, score: %.2f\n", rec->id, rec->name, rec->score);
}

int main() {
    Record records[] = {
        {1, "Alice", 95.5},
        {2, "Bob", 88.0},
        {3, "Charlie", 72.3}
    };
    int numRecords = sizeof(records) / sizeof(Record);

    for (int i = 0; i < numRecords; i++) {
        printRecordWithRenamedColumn(&records[i]);
    }

    return 0;
}