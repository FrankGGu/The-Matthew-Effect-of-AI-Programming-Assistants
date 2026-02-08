int maxProfitAssignment(int* difficulty, int* profit, int profitSize, int* worker, int workerSize) {
    int i, j, maxProfit = 0;
    int* jobs = malloc(sizeof(int) * profitSize);

    for (i = 0; i < profitSize; i++) {
        jobs[i] = profit[i];
    }

    for (i = 0; i < profitSize; i++) {
        for (j = i + 1; j < profitSize; j++) {
            if (difficulty[i] > difficulty[j]) {
                int temp = difficulty[i];
                difficulty[i] = difficulty[j];
                difficulty[j] = temp;
                temp = jobs[i];
                jobs[i] = jobs[j];
                jobs[j] = temp;
            }
        }
    }

    int maxJobProfit = 0;
    for (i = 0; i < profitSize; i++) {
        if (jobs[i] > maxJobProfit) {
            maxJobProfit = jobs[i];
        }
        jobs[i] = maxJobProfit;
    }

    for (i = 0; i < workerSize; i++) {
        for (j = 0; j < profitSize; j++) {
            if (worker[i] >= difficulty[j]) {
                maxProfit += jobs[j];
            } else {
                break;
            }
        }
    }

    free(jobs);
    return maxProfit;
}