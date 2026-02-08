int numFriendRequests(int* ages, int agesSize) {
    int count[121] = {0};
    for (int i = 0; i < agesSize; i++) {
        count[ages[i]]++;
    }

    int requests = 0;
    for (int a = 1; a <= 120; a++) {
        for (int b = 1; b <= 120; b++) {
            if (b <= 0.5 * a + 7) continue;
            if (b > a) continue;
            if (b > 100 && a < 100) continue;

            if (a == b) {
                requests += count[a] * (count[a] - 1);
            } else {
                requests += count[a] * count[b];
            }
        }
    }

    return requests;
}