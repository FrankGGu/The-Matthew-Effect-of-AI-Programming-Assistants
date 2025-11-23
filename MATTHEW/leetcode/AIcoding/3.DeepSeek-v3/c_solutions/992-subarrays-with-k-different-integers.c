int subarraysWithKDistinct(int* nums, int numsSize, int k) {
    int* count1 = (int*)calloc(numsSize + 1, sizeof(int));
    int* count2 = (int*)calloc(numsSize + 1, sizeof(int));
    int left1 = 0, left2 = 0, distinct1 = 0, distinct2 = 0, result = 0;

    for (int right = 0; right < numsSize; right++) {
        if (count1[nums[right]] == 0) distinct1++;
        count1[nums[right]]++;

        if (count2[nums[right]] == 0) distinct2++;
        count2[nums[right]]++;

        while (distinct1 > k) {
            count1[nums[left1]]--;
            if (count1[nums[left1]] == 0) distinct1--;
            left1++;
        }

        while (distinct2 >= k) {
            count2[nums[left2]]--;
            if (count2[nums[left2]] == 0) distinct2--;
            left2++;
        }

        result += left2 - left1;
    }

    free(count1);
    free(count2);
    return result;
}