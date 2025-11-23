#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSquares(int** matrix, int matrixSize, int* matrixColSize){
    int n = matrixSize;
    int m = *matrixColSize;
    int dp[n][m];
    int count = 0;

    for(int i=0; i<n; i++){
        for(int j=0; j<m; j++){
            if(i==0 || j==0){
                dp[i][j] = matrix[i][j];
            } else if(matrix[i][j] == 1){
                dp[i][j] = 1 + fmin(dp[i-1][j-1], fmin(dp[i-1][j], dp[i][j-1]));
            } else {
                dp[i][j] = 0;
            }
            count += dp[i][j];
        }
    }
    return count;
}