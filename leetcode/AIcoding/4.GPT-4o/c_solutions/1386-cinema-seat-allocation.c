int maxNumberOfFamilies(int n, int** reservedSeats, int reservedSeatsSize, int* reservedSeatsColSize) {
    int seats[1001] = {0};
    for (int i = 0; i < reservedSeatsSize; i++) {
        seats[reservedSeats[i][0]] |= (1 << (reservedSeats[i][1] - 1));
    }

    int maxFamilies = 0;
    for (int i = 1; i <= n; i++) {
        int r = seats[i];
        int count = 0;
        if ((r & 0b11110000) == 0) count++; // check 2,3,4,5
        if ((r & 0b00001111) == 0) count++; // check 1,2,3,4
        if ((r & 0b11100000) == 0) count++; // check 2,3,4,5
        if ((r & 0b00011100) == 0) count++; // check 4,5,6,7
        maxFamilies += count > 0 ? count : 1;
    }
    return maxFamilies;
}