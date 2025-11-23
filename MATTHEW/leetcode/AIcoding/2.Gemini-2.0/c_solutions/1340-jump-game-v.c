#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxJumps(int* arr, int arrSize, int d){
    int *dp = (int*)malloc(sizeof(int) * arrSize);
    for(int i = 0; i < arrSize; i++){
        dp[i] = 0;
    }

    int maxJump(int index){
        if(dp[index] != 0){
            return dp[index];
        }

        int max = 1;
        for(int i = index + 1; i <= index + d && i < arrSize; i++){
            if(arr[i] >= arr[index]){
                break;
            }
            int jump = maxJump(i) + 1;
            if(jump > max){
                max = jump;
            }
        }

        for(int i = index - 1; i >= index - d && i >= 0; i--){
            if(arr[i] >= arr[index]){
                break;
            }
            int jump = maxJump(i) + 1;
            if(jump > max){
                max = jump;
            }
        }

        dp[index] = max;
        return max;
    }

    int result = 0;
    for(int i = 0; i < arrSize; i++){
        int jump = maxJump(i);
        if(jump > result){
            result = jump;
        }
    }

    free(dp);
    return result;
}