#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}

int maxSubsetSize(int* nums, int numsSize){
    qsort(nums, numsSize, sizeof(int), cmpfunc);
    int count = 0;
    int i = 0;
    while(i < numsSize){
        if(nums[i] == 1){
            count++;
            i++;
        } else {
            break;
        }
    }
    if(count > 0){
        if(count % 2 == 0){
            count--;
        }
        return count;
    }

    int max_len = 0;
    for(int j = 0; j < numsSize; j++){
        long long curr = nums[j];
        int len = 1;
        int k = j + 1;
        while(k < numsSize){
            long long next = curr * curr;
            if(next > 100000){
                break;
            }
            int l = k;
            while(l < numsSize){
                if(nums[l] == next){
                    len++;
                    curr = next;
                    k = l + 1;
                    break;
                }
                l++;
            }
            if(l == numsSize){
                break;
            }
        }

        if(curr != 1 && curr * curr <= 100000){

            int l = 0;
            while(l < numsSize){
                if(nums[l] == curr * curr){
                    len++;
                    break;
                }
                l++;
            }
            if(l == numsSize){
                len--;
            }

        }
        if(len % 2 == 0) len--;
        if(len > max_len){
            max_len = len;
        }
    }
    return max_len;
}