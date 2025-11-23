int minPeopleToTeach(int n, int** languages, int languagesSize, int* languagesColSize, int** friendships, int friendshipsSize, int* friendshipsColSize) {
    int langKnown[n + 1];
    for (int i = 1; i <= n; i++) {
        langKnown[i] = 0;
        for (int j = 0; j < languagesColSize[i - 1]; j++) {
            langKnown[i] |= (1 << languages[i - 1][j]);
        }
    }

    int needTeach[friendshipsSize];
    int needCount = 0;
    for (int i = 0; i < friendshipsSize; i++) {
        int u = friendships[i][0], v = friendships[i][1];
        if ((langKnown[u] & langKnown[v]) == 0) {
            needTeach[needCount++] = i;
        }
    }

    if (needCount == 0) return 0;

    int minTeach = n;
    for (int lang = 1; lang <= n; lang++) {
        int teachSet[n + 1];
        for (int i = 1; i <= n; i++) teachSet[i] = 0;

        for (int i = 0; i < needCount; i++) {
            int idx = needTeach[i];
            int u = friendships[idx][0], v = friendships[idx][1];
            if ((langKnown[u] & (1 << lang)) == 0 && (langKnown[v] & (1 << lang)) == 0) {
                if ((langKnown[u] & (1 << lang)) == 0) teachSet[u] = 1;
                if ((langKnown[v] & (1 << lang)) == 0) teachSet[v] = 1;
            }
        }

        int count = 0;
        for (int i = 1; i <= n; i++) {
            if (teachSet[i]) count++;
        }
        if (count < minTeach) minTeach = count;
    }

    return minTeach;
}