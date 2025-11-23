#include <stdio.h>
#include <stdlib.h>

int maxScore(int* nums, int numsSize, int k) {
    int* heap = (int*)malloc(k * sizeof(int));
    for (int i = 0; i < k; i++) {
        heap[i] = nums[i];
    }

    for (int i = (k - 1) / 2; i >= 0; i--) {
        int j = i;
        while (j * 2 + 1 < k) {
            int left = j * 2 + 1;
            int right = j * 2 + 2;
            int max = left;
            if (right < k && heap[right] > heap[left]) {
                max = right;
            }
            if (heap[j] < heap[max]) {
                int temp = heap[j];
                heap[j] = heap[max];
                heap[max] = temp;
                j = max;
            } else {
                break;
            }
        }
    }

    int score = 0;
    for (int i = 0; i < k; i++) {
        score += heap[0];
        heap[0] = nums[k + i];
        int j = 0;
        while (j * 2 + 1 < k) {
            int left = j * 2 + 1;
            int right = j * 2 + 2;
            int max = left;
            if (right < k && heap[right] > heap[left]) {
                max = right;
            }
            if (heap[j] < heap[max]) {
                int temp = heap[j];
                heap[j] = heap[max];
                heap[max] = temp;
                j = max;
            } else {
                break;
            }
        }
    }

    free(heap);
    return score;
}