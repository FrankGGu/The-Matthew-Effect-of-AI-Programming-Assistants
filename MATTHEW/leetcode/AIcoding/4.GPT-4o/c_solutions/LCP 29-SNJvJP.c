int maxNumberOfFamilies(int n, int** reservedSeats, int reservedSeatsSize, int* reservedSeatsColSize) {
    int count = 0;
    int row[1001] = {0};

    for (int i = 0; i < reservedSeatsSize; i++) {
        row[reservedSeats[i][0]] |= 1 << (reservedSeats[i][1] - 1);
    }

    count += (n - reservedSeatsSize) * 2; // For each row that is not reserved, we can place 2 families

    for (int i = 1; i <= n; i++) {
        if (row[i] == 0) continue; // This row is fully available
        if ((row[i] & 0b11110000) == 0) count++; // Family in seats 2-5
        if ((row[i] & 0b00001111) == 0) count++; // Family in seats 6-9
        if ((row[i] & 0b11100000) == 0) count++; // Family in seats 1-4
    }

    return count;
}