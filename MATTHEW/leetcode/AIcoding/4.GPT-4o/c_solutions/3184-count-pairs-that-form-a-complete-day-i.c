int countPairs(int* days, int daysSize) {
    int count = 0;
    int freq[7] = {0};

    for (int i = 0; i < daysSize; i++) {
        freq[days[i] % 7]++;
    }

    count += (freq[0] * (freq[0] - 1)) / 2; // pairs of days % 7 == 0
    for (int i = 1; i < 4; i++) {
        count += freq[i] * freq[7 - i];
    }

    return count;
}