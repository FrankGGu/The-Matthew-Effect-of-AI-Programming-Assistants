#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

long long maxScore(int* nums1, int nums1Size, int* nums2, int nums2Size, int k) {
    int indices[nums1Size];
    for (int i = 0; i < nums1Size; i++) {
        indices[i] = i;
    }

    qsort(indices, nums1Size, sizeof(int), [&](const void *a, const void *b) {
        return nums2[*(int *)b] - nums2[*(int *)a];
    });

    long long sum = 0;
    int heap[k];
    for (int i = 0; i < k; i++) {
        heap[i] = nums1[indices[i]];
        sum += nums1[indices[i]];
    }

    qsort(heap, k, sizeof(int), cmp);

    long long max_score = sum * nums2[indices[0]];

    for (int i = k; i < nums1Size; i++) {
        if (nums1[indices[i]] > heap[0]) {
            sum -= heap[0];
            sum += nums1[indices[i]];
            heap[0] = nums1[indices[i]];

            int j = 0;
            while (j < k - 1 && heap[j] > heap[j + 1]) {
                int temp = heap[j];
                heap[j] = heap[j + 1];
                heap[j + 1] = temp;
                j++;
            }

            long long current_score = sum * nums2[indices[i]];
            if (current_score > max_score) {
                max_score = current_score;
            }
        }
    }

    return max_score;
}