typedef long long ll;

long long countCompleteDayPairs(int* hours, int hoursSize) {
    int freq[24] = {0};
    ll count = 0;

    for (int i = 0; i < hoursSize; i++) {
        int rem = hours[i] % 24;
        int complement = (24 - rem) % 24;
        count += freq[complement];
        freq[rem]++;
    }

    return count;
}