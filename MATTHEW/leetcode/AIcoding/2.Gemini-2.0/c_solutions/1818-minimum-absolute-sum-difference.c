#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}

int minAbsoluteSumDiff(int* nums1, int nums1Size, int* nums2, int nums2Size){
    long long sum = 0;
    int *sorted_nums1 = (int*)malloc(nums1Size * sizeof(int));
    for(int i = 0; i < nums1Size; i++){
        sorted_nums1[i] = nums1[i];
        sum += abs(nums1[i] - nums2[i]);
    }
    qsort(sorted_nums1, nums1Size, sizeof(int), cmpfunc);

    long long max_diff_reduction = 0;
    for(int i = 0; i < nums1Size; i++){
        int diff = abs(nums1[i] - nums2[i]);
        int left = 0, right = nums1Size - 1;
        int closest = sorted_nums1[0];
        while(left <= right){
            int mid = left + (right - left) / 2;
            if(abs(sorted_nums1[mid] - nums2[i]) < abs(closest - nums2[i])){
                closest = sorted_nums1[mid];
            }
            if(sorted_nums1[mid] < nums2[i]){
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        long long diff_reduction = diff - abs(closest - nums2[i]);
        if(diff_reduction > max_diff_reduction){
            max_diff_reduction = diff_reduction;
        }
    }

    free(sorted_nums1);
    return (sum - max_diff_reduction + 1000000007) % 1000000007;
}