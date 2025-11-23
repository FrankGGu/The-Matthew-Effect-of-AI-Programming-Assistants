#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int gcd(int a, int b) {
    while (b) {
        int t = b;
        b = a % b;
        a = t;
    }
    return a;
}

int maxScoreHelper(int* nums, int n, int* visited, int index, int score) {
    if (index == n) return score;
    int max_score = 0;
    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            visited[i] = 1;
            for (int j = i + 1; j < n; j++) {
                if (!visited[j]) {
                    int g = gcd(nums[i], nums[j]);
                    int new_score = score + g;
                    int temp = maxScoreHelper(nums, n, visited, index + 1, new_score);
                    if (temp > max_score) max_score = temp;
                }
            }
            visited[i] = 0;
        }
    }
    return max_score;
}

int maxScore(int* nums, int numsSize) {
    int* visited = (int*)malloc(numsSize * sizeof(int));
    memset(visited, 0, numsSize * sizeof(int));
    int result = maxScoreHelper(nums, numsSize, visited, 0, 0);
    free(visited);
    return result;
}