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
    int left = 0;
    int right = n - 1;
    int ans = 0;
    int sum = 0;

    while (left <= right) {
        int l = fruits[left][0];
        int r = fruits[right][0];
        int dist = abs(startPos - l) + abs(startPos - r) + min(abs(startPos - l), abs(startPos - r));

        if (dist <= k) {
            sum = 0;
            for (int i = left; i <= right; i++) {
                sum += fruits[i][1];
            }
            ans = max(ans, sum);
            right--;
        } else {
            left++;
            right = n - 1;
        }
    }

    left = 0;
    right = n - 1;
    sum = 0;

    while (left <= right) {
        int l = fruits[left][0];
        int r = fruits[right][0];
        int dist = abs(startPos - l) + abs(startPos - r) + min(abs(startPos - l), abs(startPos - r));

        if (dist <= k) {
            sum = 0;
            for (int i = left; i <= right; i++) {
                sum += fruits[i][1];
            }
            ans = max(ans, sum);
            left++;
        } else {
            right--;
            left = 0;
        }
    }

    left = 0;
    right = 0;
    sum = 0;

    while (right < n){

        int l = fruits[left][0];
        int r = fruits[right][0];
        int dist = abs(startPos - l) + abs(startPos - r) + min(abs(startPos - l), abs(startPos - r));

        if(dist <= k){
            sum = 0;
            for(int i = left; i <= right; i++){
                sum += fruits[i][1];
            }
            ans = max(ans, sum);
            right++;
        }
        else{
            sum -= fruits[left][1];
            left++;
            if(left > right && left < n){
                right = left;
            }
        }
    }

    return ans;
}