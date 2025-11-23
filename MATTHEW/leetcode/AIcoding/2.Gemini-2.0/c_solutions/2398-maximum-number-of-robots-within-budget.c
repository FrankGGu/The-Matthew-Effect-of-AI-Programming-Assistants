#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumRobots(int* cost, int costSize, int* runningCost, int runningCostSize, long long budget) {
    int left = 0, right = 0;
    long long currentCost = 0;
    int maxRobots = 0;
    int maxRunningCost = 0;
    int* deque = (int*)malloc(sizeof(int) * (runningCostSize + 1));
    int front = 0, rear = 0;

    while (right < runningCostSize) {
        currentCost += cost[right];

        while (front < rear && runningCost[deque[rear - 1]] <= runningCost[right]) {
            rear--;
        }
        deque[rear++] = right;

        while (front < rear && deque[front] < left) {
            front++;
        }

        maxRunningCost = runningCost[deque[front]];

        while (currentCost + (long long)(right - left + 1) * maxRunningCost > budget) {
            currentCost -= cost[left];
            left++;

            while (front < rear && deque[front] < left) {
                front++;
            }
            if(front < rear){
                maxRunningCost = runningCost[deque[front]];
            } else {
                maxRunningCost = 0;
            }
        }

        if (currentCost + (long long)(right - left + 1) * maxRunningCost <= budget) {
            if (right - left + 1 > maxRobots) {
                maxRobots = right - left + 1;
            }
        }

        right++;
    }

    free(deque);
    return maxRobots;
}