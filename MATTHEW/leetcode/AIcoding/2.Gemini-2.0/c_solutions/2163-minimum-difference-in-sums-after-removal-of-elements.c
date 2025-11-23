#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long minimumDifference(int* nums, int numsSize){
    int n = numsSize / 3;
    long long *leftSum = (long long*)malloc((n + 1) * sizeof(long long));
    long long *rightSum = (long long*)malloc((n + 1) * sizeof(long long));

    long long sum = 0;
    int *heap = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        heap[i] = nums[i];
        sum += nums[i];
    }

    for (int i = n / 2 - 1; i >= 0; i--) {
        int largest = i;
        int l = 2 * i + 1;
        int r = 2 * i + 2;

        if (l < n && heap[l] > heap[largest])
            largest = l;

        if (r < n && heap[r] > heap[largest])
            largest = r;

        if (largest != i) {
            int temp = heap[i];
            heap[i] = heap[largest];
            heap[largest] = temp;

            i = n / 2; 
            i--; 
            if(i < 0) break;
        }
    }

    leftSum[0] = sum;
    for (int i = n; i < 2 * n; i++) {
        if (nums[i] < heap[0]) {
            sum -= heap[0];
            sum += nums[i];
            heap[0] = nums[i];

            int idx = 0;
            while(1){
                int largest = idx;
                int l = 2 * idx + 1;
                int r = 2 * idx + 2;

                if (l < n && heap[l] > heap[largest])
                    largest = l;

                if (r < n && heap[r] > heap[largest])
                    largest = r;

                if (largest != idx) {
                    int temp = heap[idx];
                    heap[idx] = heap[largest];
                    heap[largest] = temp;
                    idx = largest;
                } else {
                    break;
                }
            }
        }
        leftSum[i - n + 1] = sum;
    }

    free(heap);

    sum = 0;
    heap = (int*)malloc(n * sizeof(int));
    for (int i = 2 * n; i < 3 * n; i++) {
        heap[i - 2 * n] = nums[i];
        sum += nums[i];
    }

    for (int i = n / 2 - 1; i >= 0; i--) {
        int smallest = i;
        int l = 2 * i + 1;
        int r = 2 * i + 2;

        if (l < n && heap[l] < heap[smallest])
            smallest = l;

        if (r < n && heap[r] < heap[smallest])
            smallest = r;

        if (smallest != i) {
            int temp = heap[i];
            heap[i] = heap[smallest];
            heap[smallest] = temp;

            i = n/2;
            i--;
            if(i < 0) break;
        }
    }

    rightSum[n] = sum;
    for (int i = 2 * n - 1; i >= n; i--) {
        if (nums[i] > heap[0]) {
            sum -= heap[0];
            sum += nums[i];
            heap[0] = nums[i];

            int idx = 0;
            while(1){
                int smallest = idx;
                int l = 2 * idx + 1;
                int r = 2 * idx + 2;

                if (l < n && heap[l] < heap[smallest])
                    smallest = l;

                if (r < n && heap[r] < heap[smallest])
                    smallest = r;

                if (smallest != idx) {
                    int temp = heap[idx];
                    heap[idx] = heap[smallest];
                    heap[smallest] = temp;
                    idx = smallest;
                } else {
                    break;
                }
            }
        }
        rightSum[i - n] = sum;
    }

    free(heap);

    long long minDiff = LLONG_MAX;
    for (int i = 0; i <= n; i++) {
        long long diff = leftSum[i] - rightSum[i];
        if (diff < minDiff) {
            minDiff = diff;
        }
    }

    free(leftSum);
    free(rightSum);

    return minDiff;
}