#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool sumGame(char * num) {
    int n = 0;
    while (num[n] != '\0') {
        n++;
    }

    int leftSum = 0;
    int leftCount = 0;
    int rightSum = 0;
    int rightCount = 0;

    for (int i = 0; i < n / 2; i++) {
        if (num[i] == '?') {
            leftCount++;
        } else {
            leftSum += (num[i] - '0');
        }
    }

    for (int i = n / 2; i < n; i++) {
        if (num[i] == '?') {
            rightCount++;
        } else {
            rightSum += (num[i] - '0');
        }
    }

    if ((leftCount + rightCount) % 2 != 0) {
        return true;
    }

    if (leftCount == rightCount) {
        return leftSum != rightSum;
    }

    if (leftCount > rightCount) {
        return leftSum + (leftCount - rightCount) / 2 * 9 != rightSum;
    } else {
        return rightSum + (rightCount - leftCount) / 2 * 9 != leftSum;
    }
}