#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minWastedSpace(int* packages, int packagesSize, int* boxes, int boxesSize, int* boxSizes, int boxSizesSize){
    long long minWaste = -1;
    long long MOD = 1000000007;

    qsort(packages, packagesSize, sizeof(int), compare);

    for (int i = 0; i < boxSizesSize; i++) {
        int boxSize = boxSizes[i];
        qsort(boxes + i * boxesSize, boxesSize, sizeof(int), compare);

        long long currentWaste = 0;
        int packageIndex = 0;
        int valid = 1;

        for (int j = 0; j < boxesSize; j++) {
            if (boxes[i * boxesSize + j] < packages[0]) {
                continue;
            }
            long long boxCapacity = (long long)boxes[i * boxesSize + j];
            int count = 0;

            while (packageIndex < packagesSize && packages[packageIndex] <= boxes[i * boxesSize + j]) {
                packageIndex++;
                count++;
            }
            currentWaste = (currentWaste + (long long)boxes[i * boxesSize + j] * count) % MOD;

            if(packageIndex >= packagesSize) break;
        }

        if(packageIndex < packagesSize) {
            valid = 0;
        }

        if (valid) {
            long long totalPackageSize = 0;
            for (int k = 0; k < packagesSize; k++) {
                totalPackageSize = (totalPackageSize + packages[k]) % MOD;
            }
            long long waste = (currentWaste - totalPackageSize + MOD) % MOD;
            if (minWaste == -1 || waste < minWaste) {
                minWaste = waste;
            }
        }
    }

    return (int)minWaste;
}