#include <string.h>

int bestClosingTime(char * customers){
    int n = strlen(customers);

    // Calculate initial penalty for closing at hour 0.
    // If shop closes at hour 0, all hours from 0 to n-1 are closed.
    // Penalty is the count of 'Y's in customers[0...n-1].
    int current_penalty = 0;
    for (int i = 0; i < n; i++) {
        if (customers[i] == 'Y') {
            current_penalty++;
        }
    }

    int min_penalty = current_penalty;
    int min_j = 0; // The earliest closing time that yields min_penalty

    // Iterate through possible closing times j from 1 to n.
    // When moving from closing time j-1 to j:
    // The hour (j-1) changes its status from "closed" to "open".
    // - If customers[j-1] was 'Y': It was contributing +1 to penalty (Y in closed part).
    //   Now it contributes +0 (Y in open part). So, penalty decreases by 1.
    // - If customers[j-1] was 'N': It was contributing +0 to penalty (N in closed part).
    //   Now it contributes +1 (N in open part). So, penalty increases by 1.
    for (int j = 1; j <= n; j++) {
        if (customers[j-1] == 'Y') {
            current_penalty--;
        } else { // customers[j-1] == 'N'
            current_penalty++;
        }

        // If a new minimum penalty is found, update min_penalty and min_j.
        // We use strictly less than to ensure that if multiple closing times
        // yield the same minimum penalty, we keep the earliest one.
        if (current_penalty < min_penalty) {
            min_penalty = current_penalty;
            min_j = j;
        }
    }

    return min_j;
}