int maximumGood(int** statements, int statementsSize, int* statementsColSize) {
    int n = statementsSize;
    int maxGoodPeople = 0;

    for (int mask = 0; mask < (1 << n); ++mask) {
        int currentGoodPeopleCount = 0;
        int isValidAssignment = 1;

        for (int i = 0; i < n; ++i) {
            if ((mask >> i) & 1) { // If person i is assumed to be good in this assignment
                currentGoodPeopleCount++;
            }
        }

        for (int i = 0; i < n; ++i) {
            if ((mask >> i) & 1) { // If person i is assumed to be good
                // Good people must tell the truth
                for (int j = 0; j < n; ++j) {
                    if (statements[i][j] == 0) { // Person i states person j is bad
                        // In this assignment, person j must be bad
                        if ((mask >> j) & 1) { // If person j is good in this assignment, it's a contradiction
                            isValidAssignment = 0;
                            break;
                        }
                    } else if (statements[i][j] == 1) { // Person i states person j is good
                        // In this assignment, person j must be good
                        if (!((mask >> j) & 1)) { // If person j is bad in this assignment, it's a contradiction
                            isValidAssignment = 0;
                            break;
                        }
                    }
                    // If statements[i][j] == -1, person i made no statement about person j, so it's always consistent.
                }
            }
            if (!isValidAssignment) {
                break;
            }
        }

        if (isValidAssignment) {
            if (currentGoodPeopleCount > maxGoodPeople) {
                maxGoodPeople = currentGoodPeopleCount;
            }
        }
    }

    return maxGoodPeople;
}