int maxScore(int* nums1, int nums1Size, int* nums2, int nums2Size, int k) {
    int max_score = 0;
    int* indices = (int*)malloc(k * sizeof(int));
    for (int i = 0; i < k; i++) {
        indices[i] = i;
    }

    while (1) {
        int current_score = 0;
        for (int i = 0; i < k; i++) {
            current_score += nums1[indices[i]];
        }
        int min_num2 = INT_MAX;
        for (int i = 0; i < k; i++) {
            if (nums2[indices[i]] < min_num2) {
                min_num2 = nums2[indices[i]];
            }
        }
        max_score = fmax(max_score, current_score * min_num2);

        int j = k - 1;
        while (j >= 0 && indices[j] == nums1Size - (k - j)) {
            j--;
        }
        if (j < 0) break;
        indices[j]++;
        for (int i = j + 1; i < k; i++) {
            indices[i] = indices[i - 1] + 1;
        }
    }

    free(indices);
    return max_score;
}