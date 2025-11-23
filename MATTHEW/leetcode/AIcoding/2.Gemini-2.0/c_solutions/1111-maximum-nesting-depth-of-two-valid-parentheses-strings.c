#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxDepthAfterSplit(char * seq, int* returnSize){
    int n = strlen(seq);
    int* ans = (int*)malloc(n * sizeof(int));
    *returnSize = n;
    int depthA = 0, depthB = 0;
    for (int i = 0; i < n; i++) {
        if (seq[i] == '(') {
            if (depthA < depthB) {
                ans[i] = 0;
                depthA++;
            } else {
                ans[i] = 1;
                depthB++;
            }
        } else {
            if (depthA < depthB) {
                depthB--;
                ans[i] = 1;
            } else {
                depthA--;
                ans[i] = 0;
            }
        }
    }
    return ans;
}