#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int min(int a, int b) {
    return (a < b) ? a : b;
}

int maxTotalFruits(int** fruits, int fruitsSize, int* fruitsColSize, int startPos, int k) {
    int n = fruitsSize;
    int maxFruits = 0;
    int left = 0;
    int right = n - 1;

    while (left <= right && fruits[left][0] < startPos - k) {
        left++;
    }

    while (right >= left && fruits[right][0] > startPos + k) {
        right--;
    }

    for (int i = left; i <= right; i++) {
        int pos = fruits[i][0];
        int dist = abs(pos - startPos);

        if (dist > k) {
            continue;
        }

        int fruitsCollected = 0;
        int currentLeft = left;
        int currentRight = i;

        if (pos <= startPos) {
            while (currentLeft <= currentRight) {
                fruitsCollected += fruits[currentLeft][1];
                currentLeft++;
            }
            int remaining = k - dist;
            int furthestRight = startPos + remaining;

            while (currentRight < n && fruits[currentRight][0] <= furthestRight) {
                fruitsCollected += fruits[currentRight][1];
                currentRight++;
            }
            currentRight--;

            maxFruits = max(maxFruits, fruitsCollected);
        } else {
            while (currentLeft <= currentRight) {
                fruitsCollected += fruits[currentLeft][1];
                currentLeft++;
            }
            int remaining = k - dist;
            int furthestLeft = startPos - remaining;

            currentLeft = left - 1;
            while(currentLeft >= 0 && fruits[currentLeft][0] >= furthestLeft) {
                fruitsCollected += fruits[currentLeft][1];
                currentLeft--;
            }

            maxFruits = max(maxFruits, fruitsCollected);
        }
    }

    for (int i = right; i >= left; i--) {
        int pos = fruits[i][0];
        int dist = abs(pos - startPos);

        if (dist > k) {
            continue;
        }

        int fruitsCollected = 0;
        int currentLeft = i;
        int currentRight = right;

        if (pos >= startPos) {
            while (currentLeft <= currentRight) {
                fruitsCollected += fruits[currentLeft][1];
                currentLeft++;
            }
            int remaining = k - dist;
            int furthestLeft = startPos - remaining;

            while (i > 0 && i > left && fruits[i-1][0] >= furthestLeft) {
                i--;
            }

            maxFruits = max(maxFruits, fruitsCollected);
        } else {
            while (currentLeft <= currentRight) {
                fruitsCollected += fruits[currentLeft][1];
                currentLeft++;
            }
            int remaining = k - dist;
            int furthestRight = startPos + remaining;

            maxFruits = max(maxFruits, fruitsCollected);
        }
    }

    int totalFruits = 0;
    int l = 0, r = 0;
    while(r < fruitsSize){
        if(fruits[r][0] - fruits[l][0] <= k){
            totalFruits += fruits[r][1];
            r++;
        } else {
            totalFruits -= fruits[l][1];
            l++;
        }
        maxFruits = max(maxFruits, totalFruits);
    }

    totalFruits = 0;
    l = fruitsSize - 1, r = fruitsSize - 1;
    while(l >= 0){
        if(fruits[r][0] - fruits[l][0] <= k){
            totalFruits += fruits[l][1];
            l--;
        } else {
            totalFruits -= fruits[r][1];
            r--;
        }
        maxFruits = max(maxFruits, totalFruits);
    }

    int ans = 0;
    for(int i = 0; i < fruitsSize; i++){
        int fruitsCollected = 0;
        int dist = abs(fruits[i][0] - startPos);
        if(dist <= k){
            int rem = k - dist;
            int tempFruits = fruits[i][1];

            int leftBound = min(startPos, fruits[i][0]) - rem;
            int rightBound = max(startPos, fruits[i][0]) + rem;

            for(int j = 0; j < fruitsSize; j++){
                if(i == j) continue;
                if(fruits[j][0] >= leftBound && fruits[j][0] <= rightBound){
                    tempFruits += fruits[j][1];
                }
            }
            ans = max(ans, tempFruits);
        }
    }

    int finalAns = 0;
    for(int i = 0; i < fruitsSize; ++i){
        int dist = abs(fruits[i][0] - startPos);
        if(dist <= k){
            finalAns += fruits[i][1];
        }
    }

    maxFruits = 0;
    for(int i = 0; i < fruitsSize; i++){
        int dist = abs(fruits[i][0] - startPos);
        if(dist <= k){
            int collected = 0;
            if(fruits[i][0] <= startPos){
                int remaining = k - abs(fruits[i][0] - startPos);
                int maxRight = startPos + remaining;

                int lIndex = i;
                while(lIndex < fruitsSize && fruits[lIndex][0] <= maxRight){
                   collected += fruits[lIndex][1];
                   lIndex++;
                }
                maxFruits = max(maxFruits, collected);
            } else {
                int remaining = k - abs(fruits[i][0] - startPos);
                int minLeft = startPos - remaining;
                int rIndex = i;
                while(rIndex >= 0 && fruits[rIndex][0] >= minLeft){
                   collected += fruits[rIndex][1];
                   rIndex--;
                }
                maxFruits = max(maxFruits, collected);
            }
        }
    }

    int maxTotal = 0;
    for(int i = 0; i < fruitsSize; ++i){
        int currentTotal = 0;
        for(int j = 0; j < fruitsSize; ++j){
            if(abs(fruits[j][0] - startPos) <= k){
                currentTotal += fruits[j][1];
            }
        }
        maxTotal = max(maxTotal, currentTotal);
    }

    int res = 0;
    for(int i = 0; i < fruitsSize; i++){
        int dist = abs(fruits[i][0] - startPos);
        if(dist <= k){
            int collected = 0;
            for(int j = 0; j < fruitsSize; j++){
                int totalDist = abs(fruits[i][0] - startPos);
                if(totalDist <= k){
                    int rem = k - totalDist;
                    if(fruits[i][0] <= startPos){
                        if(fruits[j][0] >= fruits[i][0] && fruits[j][0] <= startPos + rem){
                            collected += fruits[j][1];
                        }
                    } else {
                        if(fruits[j][0] <= fruits[i][0] && fruits[j][0] >= startPos - rem){
                            collected += fruits[j][1];
                        }
                    }
                }
            }
            res = max(res, collected);
        }
    }

    int ans2 = 0;
    for(int i = 0; i < fruitsSize; ++i){
        int dist = abs(fruits[i][0] - startPos);
        if(dist <= k){
            int rem = k - dist;
            int tempFruits = fruits[i][1];

            int leftBound = min(startPos, fruits[i][0]) - rem;