#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxTotalFruits(int** fruits, int fruitsSize, int* fruitsColSize, int startPos, int k) {
    int n = fruitsSize;
    int left = 0;
    while (left < n && fruits[left][0] < startPos - k) {
        left++;
    }
    int right = n - 1;
    while (right >= 0 && fruits[right][0] > startPos + k) {
        right--;
    }
    int ans = 0;
    for (int i = left; i <= right; i++) {
        int j = i;
        while (j <= right) {
            int dist = 0;
            if (fruits[j][0] <= startPos) {
                dist = startPos - fruits[i][0] + fruits[j][0] - fruits[i][0];
            } else {
                dist = fruits[j][0] - startPos + fruits[j][0] - fruits[i][0];
            }
            if (dist <= k) {
                int sum = 0;
                for (int l = i; l <= j; l++) {
                    sum += fruits[l][1];
                }
                ans = (ans > sum) ? ans : sum;
            }
            j++;
        }
    }
    for (int i = right; i >= left; i--) {
        int j = i;
        while (j >= left) {
            int dist = 0;
            if (fruits[j][0] >= startPos) {
                dist = fruits[i][0] - startPos + fruits[i][0] - fruits[j][0];
            } else {
                dist = startPos - fruits[i][0] + fruits[i][0] - fruits[j][0];
            }
            if (dist <= k) {
                int sum = 0;
                for (int l = j; l <= i; l++) {
                    sum += fruits[l][1];
                }
                ans = (ans > sum) ? ans : sum;
            }
            j--;
        }
    }
    int sum = 0;
    for(int i = left; i <= right; i++){
        if(abs(fruits[i][0] - startPos) <= k){
            sum += fruits[i][1];
        }
    }
    ans = (ans > sum) ? ans : sum;

    ans = 0;
    for(int x = 0; x <= k; x++){
        int leftMost = startPos - x;
        int rightMost = startPos + (k - x);
        int leftIdx = -1;
        int rightIdx = -1;
        for(int i = 0; i < fruitsSize; i++){
            if(fruits[i][0] == leftMost){
                leftIdx = i;
            }
            if(fruits[i][0] == rightMost){
                rightIdx = i;
            }
        }
        if(leftIdx == -1){
            int l = 0;
            int r = fruitsSize - 1;
            int idx = -1;
            while(l <= r){
                int mid = l + (r - l) / 2;
                if(fruits[mid][0] < leftMost){
                    l = mid + 1;
                } else {
                    idx = mid;
                    r = mid - 1;
                }
            }
            if(idx != -1 && fruits[idx][0] > leftMost){
                leftIdx = idx;
            } else {
                leftIdx = -1;
            }

        }
        if(rightIdx == -1){
            int l = 0;
            int r = fruitsSize - 1;
            int idx = -1;
            while(l <= r){
                int mid = l + (r - l) / 2;
                if(fruits[mid][0] <= rightMost){
                    idx = mid;
                    l = mid + 1;
                } else {
                    r = mid - 1;
                }
            }
            if(idx != -1 && fruits[idx][0] <= rightMost){
                rightIdx = idx;
            } else {
                rightIdx = -1;
            }
        }

        if(leftIdx != -1){
            int curSum = 0;
            if(rightIdx != -1){

                int i = leftIdx;
                while(i <= rightIdx){
                    curSum += fruits[i][1];
                    i++;
                }
                ans = (ans > curSum) ? ans : curSum;
            } else {
                ans = (ans > fruits[leftIdx][1]) ? ans : fruits[leftIdx][1];
            }
        }
    }

    for(int x = 0; x <= k; x++){
        int rightMost = startPos + x;
        int leftMost = startPos - (k - x);
        int leftIdx = -1;
        int rightIdx = -1;
        for(int i = 0; i < fruitsSize; i++){
            if(fruits[i][0] == leftMost){
                leftIdx = i;
            }
            if(fruits[i][0] == rightMost){
                rightIdx = i;
            }
        }
        if(leftIdx == -1){
            int l = 0;
            int r = fruitsSize - 1;
            int idx = -1;
            while(l <= r){
                int mid = l + (r - l) / 2;
                if(fruits[mid][0] < leftMost){
                    l = mid + 1;
                } else {
                    idx = mid;
                    r = mid - 1;
                }
            }
            if(idx != -1 && fruits[idx][0] > leftMost){
                leftIdx = idx;
            } else {
                leftIdx = -1;
            }

        }
        if(rightIdx == -1){
            int l = 0;
            int r = fruitsSize - 1;
            int idx = -1;
            while(l <= r){
                int mid = l + (r - l) / 2;
                if(fruits[mid][0] <= rightMost){
                    idx = mid;
                    l = mid + 1;
                } else {
                    r = mid - 1;
                }
            }
            if(idx != -1 && fruits[idx][0] <= rightMost){
                rightIdx = idx;
            } else {
                rightIdx = -1;
            }
        }

        if(rightIdx != -1){
            int curSum = 0;
            if(leftIdx != -1){

                int i = leftIdx;
                while(i <= rightIdx){
                    curSum += fruits[i][1];
                    i++;
                }
                ans = (ans > curSum) ? ans : curSum;
            } else {
                ans = (ans > fruits[rightIdx][1]) ? ans : fruits[rightIdx][1];
            }
        }
    }

    return ans;
}