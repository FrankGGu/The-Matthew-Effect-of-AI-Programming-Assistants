#include <stdlib.h> // For qsort
#include <stdbool.h> // For bool type

int compare(const void *a, const void *b) {
    const int *arrA = *(const int **)a;
    const int *arrB = *(const int **)b;
    if (arrA[0] != arrB[0]) {
        return arrA[0] - arrB[0];
    }
    return arrA[1] - arrB[1];
}

int maxNumberOfFamilies(int n, int** reservedSeats, int reservedSeatsSize, int* reservedSeatsColSize) {
    int totalFamilies = 0;

    // If no seats are reserved, all 'n' rows can accommodate 2 families each.
    if (reservedSeatsSize == 0) {
        return n * 2;
    }

    // Sort the reserved seats to easily process them row by row.
    qsort(reservedSeats, reservedSeatsSize, sizeof(int*), compare);

    int numRowsWithReservations = 0;
    int i = 0;
    while (i < reservedSeatsSize) {
        numRowsWithReservations++;
        int currentRow = reservedSeats[i][0];

        // Use a bitmask to keep track of reserved seats 2 through 9 for the current row.
        // Bit 0 corresponds to seat 2, Bit 1 to seat 3, ..., Bit 7 to seat 9.
        // Seats 1 and 10 do not affect the family seating arrangements.
        int rowMask = 0; 
        int j = i;
        while (j < reservedSeatsSize && reservedSeats[j][0] == currentRow) {
            int col = reservedSeats[j][1];
            if (col >= 2 && col <= 9) { 
                rowMask |= (1 << (col - 2)); // Set the corresponding bit if the seat is reserved
            }
            j++;
        }

        // Define masks for the three possible 4-seat groups:
        // Group 1: Seats (2,3,4,5) -> corresponds to bits 0,1,2,3
        int group1_check_mask = (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3); // 0b00001111
        // Group 2: Seats (4,5,6,7) -> corresponds to bits 2,3,4,5
        int group2_check_mask = (1 << 2) | (1 << 3) | (1 << 4) | (1 << 5); // 0b00111100
        // Group 3: Seats (6,7,8,9) -> corresponds to bits 4,5,6,7
        int group3_check_mask = (1 << 4) | (1 << 5) | (1 << 6) | (1 << 7); // 0b11110000

        // Check if each group is available (i.e., no reserved seats overlap with the group's seats).
        // A group is available if the bitwise AND of its mask and the row's reserved mask is 0.
        bool g1_avail = (rowMask & group1_check_mask) == 0;
        bool g2_avail = (rowMask & group2_check_mask) == 0;
        bool g3_avail = (rowMask & group3_check_mask) == 0;

        // Determine how many families can be seated in the current row:
        if (g1_avail && g3_avail) { 
            // If both non-overlapping groups (2-5 and 6-9) are available, 2 families can be seated.
            totalFamilies += 2;
        } else if (g1_avail || g2_avail || g3_avail) { 
            // Otherwise, if at least one of the three groups is available, 1 family can be seated.
            totalFamilies += 1;
        }
        // If none of the groups are available, 0 families are added for this row.

        // Move to the first reservation of the next distinct row.
        i = j; 
    }

    // Add families from rows that had no reservations.
    // Each such row can accommodate 2 families.
    totalFamilies += (n - numRowsWithReservations) * 2;

    return totalFamilies;
}