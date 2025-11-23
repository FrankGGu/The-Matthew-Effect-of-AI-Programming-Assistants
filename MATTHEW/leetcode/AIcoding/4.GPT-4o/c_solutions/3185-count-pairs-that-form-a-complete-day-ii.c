int countPairs(int* days, int daysSize) {
    int count = 0;
    int freq[7] = {0};

    for (int i = 0; i < daysSize; i++) {
        int dayIndex = (days[i] - 1) % 7;
        count += freq[dayIndex];
        freq[dayIndex]++;
    }

    return count;
}