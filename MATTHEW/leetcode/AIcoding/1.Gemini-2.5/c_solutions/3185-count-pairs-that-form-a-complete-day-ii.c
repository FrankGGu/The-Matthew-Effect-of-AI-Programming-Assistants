long long countPairs(int* hours, int hoursSize) {
    long long pair_count = 0;
    int counts[24] = {0}; // Stores frequency of remainders modulo 24

    for (int i = 0; i < hoursSize; i++) {
        int hour = hours[i];
        int remainder = hour % 24;

        // Calculate the complement remainder needed to sum to a multiple of 24
        // If remainder is 0, complement is 0.
        // If remainder is X (e.g., 5), complement is 24 - X (e.g., 19).
        int complement_remainder = (24 - remainder) % 24;

        // Add the count of previously seen numbers with the complement remainder
        // to the total pair count.
        pair_count += counts[complement_remainder];

        // Increment the count for the current remainder
        counts[remainder]++;
    }

    return pair_count;
}