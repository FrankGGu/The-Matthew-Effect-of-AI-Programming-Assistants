int minimumPeopleToTeach(int n, int** languages, int languagesSize, int* languagesColSize) {
    int taught[100] = {0};
    int totalPeople = 0;

    for (int i = 0; i < languagesSize; i++) {
        for (int j = 0; j < languagesColSize[i]; j++) {
            taught[languages[i][j]] = 1;
        }
    }

    for (int i = 0; i < languagesSize; i++) {
        int knowsLanguage = 0;
        for (int j = 0; j < languagesColSize[i]; j++) {
            if (taught[languages[i][j]]) {
                knowsLanguage = 1;
                break;
            }
        }
        if (!knowsLanguage) {
            totalPeople++;
        }
    }

    return totalPeople;
}