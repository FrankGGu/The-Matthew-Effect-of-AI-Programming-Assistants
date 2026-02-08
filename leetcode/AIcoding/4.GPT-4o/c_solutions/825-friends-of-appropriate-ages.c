int numFriendRequests(int* ages, int agesSize) {
    int count = 0;
    for (int i = 0; i < agesSize; i++) {
        for (int j = 0; j < agesSize; j++) {
            if (i != j && ages[j] > 0.5 * ages[i] + 7 && ages[j] <= ages[i]) {
                count++;
            }
        }
    }
    return count;
}