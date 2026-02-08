#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canPartitionKSubsets(int* nums, int numsSize, int k) {
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }
    if (sum % k != 0) {
        return false;
    }
    int target = sum / k;
    bool visited[numsSize];
    for (int i = 0; i < numsSize; i++) {
        visited[i] = false;
    }

    bool backtrack(int subsetSum, int elementsUsed, int startIndex) {
        if (subsetSum == target) {
            return true;
        }

        if (subsetSum > target) {
            return false;
        }

        if (elementsUsed == numsSize) {
            return false;
        }

        for (int i = startIndex; i < numsSize; i++) {
            if (!visited[i]) {
                visited[i] = true;
                if (backtrack(subsetSum + nums[i], elementsUsed + 1, i + 1)) {
                    return true;
                }
                visited[i] = false;
            }
        }
        return false;
    }

    int subsetsFound = 0;
    while (subsetsFound < k) {
        bool foundSubset = false;
        for(int i = 0; i < numsSize; i++){
            if(!visited[i]){
                if(backtrack(0,0,0)){
                    subsetsFound++;
                    foundSubset = true;
                    break;
                } else {
                    return false;
                }
            }
        }
        if(!foundSubset && subsetsFound < k){
            return false;
        }

        bool allVisited = true;
        for(int i = 0; i < numsSize; i++){
            if(!visited[i]){
                allVisited = false;
                break;
            }
        }
        if(allVisited){
            return subsetsFound == k;
        }
    }

    return true;
}