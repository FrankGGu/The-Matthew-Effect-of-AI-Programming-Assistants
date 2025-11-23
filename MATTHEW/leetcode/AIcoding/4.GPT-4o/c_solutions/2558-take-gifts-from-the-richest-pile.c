int pickGifts(int* gifts, int giftsSize, int k) {
    int total = 0;
    for (int i = 0; i < k; i++) {
        int maxIndex = 0;
        for (int j = 1; j < giftsSize; j++) {
            if (gifts[j] > gifts[maxIndex]) {
                maxIndex = j;
            }
        }
        total += gifts[maxIndex];
        gifts[maxIndex] = (int)sqrt(gifts[maxIndex]);
    }
    return total;
}