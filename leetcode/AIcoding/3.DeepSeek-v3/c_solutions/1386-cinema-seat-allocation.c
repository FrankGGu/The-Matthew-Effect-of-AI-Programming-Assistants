typedef struct {
    int row;
    int col;
} Seat;

int cmp(const void* a, const void* b) {
    Seat* s1 = (Seat*)a;
    Seat* s2 = (Seat*)b;
    if (s1->row == s2->row) {
        return s1->col - s2->col;
    }
    return s1->row - s2->row;
}

int maxNumberOfFamilies(int n, int** reservedSeats, int reservedSeatsSize, int* reservedSeatsColSize) {
    if (reservedSeatsSize == 0) {
        return n * 2;
    }

    Seat* seats = (Seat*)malloc(reservedSeatsSize * sizeof(Seat));
    for (int i = 0; i < reservedSeatsSize; i++) {
        seats[i].row = reservedSeats[i][0];
        seats[i].col = reservedSeats[i][1];
    }

    qsort(seats, reservedSeatsSize, sizeof(Seat), cmp);

    int result = 0;
    int currentRow = 0;
    int index = 0;

    for (int i = 1; i <= n; i++) {
        if (index < reservedSeatsSize && seats[index].row == i) {
            currentRow = i;
            int mask = 0;
            while (index < reservedSeatsSize && seats[index].row == currentRow) {
                mask |= (1 << (seats[index].col - 1));
                index++;
            }

            int count = 0;
            if ((mask & 0b0111111110) == 0) {
                count = 2;
            } else if ((mask & 0b0111100000) == 0 || (mask & 0b0001111000) == 0 || (mask & 0b0000011110) == 0) {
                count = 1;
            }
            result += count;
        } else {
            result += 2;
        }
    }

    free(seats);
    return result;
}