#include <stdlib.h>
#include <string.h>

typedef struct {
    long long counts[5]; // counts[0] for 20, counts[1] for 50, ..., counts[4] for 500
} ATM;

ATM* atmCreate() {
    ATM* obj = (ATM*) malloc(sizeof(ATM));
    if (obj == NULL) {
        return NULL;
    }
    for (int i = 0; i < 5; i++) {
        obj->counts[i] = 0;
    }
    return obj;
}

void atmDeposit(ATM* obj, int* banknotesCount, int banknotesCountSize) {
    // banknotesCount is an array of size 5: [20, 50, 100, 200, 500]
    for (int i = 0; i < 5; i++) {
        obj->counts[i] += banknotesCount[i];
    }
}

long long* atmWithdraw(ATM* obj, int amount) {
    // Denominations in descending order for greedy approach
    int denominations[] = {500, 200, 100, 50, 20};
    // Corresponding indices in the counts array
    int denomination_indices[] = {4, 3, 2, 1, 0}; 

    long long* withdrawn_notes = (long long*) calloc(5, sizeof(long long)); // Initialize with zeros
    if (withdrawn_notes == NULL) {
        return NULL; // Allocation failure
    }

    // Create a temporary copy of current counts to simulate withdrawal
    long long temp_counts[5];
    memcpy(temp_counts, obj->counts, sizeof(long long) * 5);

    int remaining_amount = amount;

    for (int i = 0; i < 5; i++) {
        int denom = denominations[i];
        int denom_idx = denomination_indices[i];

        if (remaining_amount == 0) {
            break; // Amount fully covered
        }

        // Calculate how many notes of current denomination can be taken
        long long num_notes_to_take = remaining_amount / denom;

        // Limit by available notes in the ATM
        if (num_notes_to_take > temp_counts[denom_idx]) {
            num_notes_to_take = temp_counts[denom_idx];
        }

        // Update remaining amount and temporary withdrawn notes count
        remaining_amount -= num_notes_to_take * denom;
        withdrawn_notes[denom_idx] = num_notes_to_take;
    }

    if (remaining_amount == 0) {
        // Withdrawal successful, update actual ATM counts
        for (int i = 0; i < 5; i++) {
            obj->counts[i] -= withdrawn_notes[i];
        }
        return withdrawn_notes; // Return the successfully withdrawn notes
    } else {
        // Withdrawal not possible
        free(withdrawn_notes); // Free the allocated memory
        return NULL; // Return NULL for an "empty array" as per problem description
    }
}

void atmFree(ATM* obj) {
    free(obj);
}