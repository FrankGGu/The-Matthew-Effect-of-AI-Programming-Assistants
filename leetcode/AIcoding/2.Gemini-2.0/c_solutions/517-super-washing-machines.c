#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findMinMoves(int* machines, int machinesSize) {
    int sum = 0;
    for (int i = 0; i < machinesSize; i++) {
        sum += machines[i];
    }

    if (sum % machinesSize != 0) {
        return -1;
    }

    int average = sum / machinesSize;
    int ans = 0;
    int balance = 0;

    for (int i = 0; i < machinesSize; i++) {
        balance += machines[i] - average;
        int need = abs(balance);
        int give = machines[i] - average;
        if (give > 0) {
            ans = (ans > give) ? ans : give;
        }
        ans = (ans > need) ? ans : need;
    }

    return ans;
}