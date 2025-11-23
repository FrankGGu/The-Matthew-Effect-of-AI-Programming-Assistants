int rand10() {
    int row, col, idx;
    while (1) {
        row = rand7();
        col = rand7();

        // Calculate a number from 1 to 49 uniformly.
        // (row - 1) * 7 generates numbers 0, 7, 14, 21, 28, 35, 42.
        // Adding col (1 to 7) to this range gives:
        // Min: (1 - 1) * 7 + 1 = 1
        // Max: (7 - 1) * 7 + 7 = 42 + 7 = 49
        idx = (row - 1) * 7 + col; 

        // We need numbers from 1 to 10.
        // The range 1 to 49 is not a multiple of 10.
        // The largest multiple of 10 less than or equal to 49 is 40.
        // If idx is between 1 and 40, we can map it to 1-10.
        if (idx <= 40) {
            // (idx - 1) % 10 maps 1-10 to 0-9, 11-20 to 0-9, etc.
            // Adding 1 shifts it to 1-10.
            return (idx - 1) % 10 + 1;
        }
        // If idx is 41, 42, ..., 49, it's discarded and we retry.
        // This rejection sampling ensures uniformity for the accepted range [1, 40].
    }
}