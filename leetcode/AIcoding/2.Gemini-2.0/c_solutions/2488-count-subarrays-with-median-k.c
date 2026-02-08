#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSubarrays(int* nums, int numsSize, int k){
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i; j < numsSize; j++) {
            int len = j - i + 1;
            int temp[len];
            for (int l = 0; l < len; l++) {
                temp[l] = nums[i + l];
            }

            int sorted[len];
            for (int l = 0; l < len; l++) {
                sorted[l] = temp[l];
            }

            for (int l = 0; l < len - 1; l++) {
                for (int m = 0; m < len - l - 1; m++) {
                    if (sorted[m] > sorted[m + 1]) {
                        int t = sorted[m];
                        sorted[m] = sorted[m + 1];
                        sorted[m + 1] = t;
                    }
                }
            }

            int median;
            if (len % 2 == 0) {
                median = (sorted[len / 2 - 1] + sorted[len / 2]) / 2;
            } else {
                median = sorted[len / 2];
            }

            int k_present = 0;
            for(int l = 0; l < len; l++){
                if(temp[l] == k){
                    k_present = 1;
                    break;
                }
            }

            if(k_present && len % 2 != 0 && sorted[len / 2] == k){
                count++;
            }
            else if(k_present && len % 2 == 0 && (sorted[len/2 -1] <= k && sorted[len/2] >= k)){
                 if((sorted[len/2 -1] + sorted[len/2]) % 2 == 0 && (sorted[len/2 -1] + sorted[len/2]) / 2 == k){
                    count++;
                } else if ((sorted[len/2 -1] + sorted[len/2]) % 2 != 0 && (k * 2 == sorted[len/2 -1] + sorted[len/2])){
                    count++;
                }

            }
        }
    }

    int res = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i; j < numsSize; j++) {
            int median_idx = (j - i) / 2;
            int arr[j - i + 1];
            int k_count = 0;
            for(int l = i; l <= j; l++){
                arr[l - i] = nums[l];
                if(nums[l] == k){
                    k_count++;
                }
            }

            if(k_count == 0){
                continue;
            }

            int smaller = 0;
            int larger = 0;
            int equal = 0;

            for(int l = 0; l <= j - i; l++){
                if(arr[l] < k){
                    smaller++;
                }
                else if(arr[l] > k){
                    larger++;
                }
                else {
                    equal++;
                }
            }

            if((j - i + 1) % 2 == 1){
                if(smaller == larger){
                    res++;
                }
            }
            else{
                if(smaller + 1 == larger){
                    res++;
                }
            }

        }
    }

    return res;
}