int countLessEqual(int* nums, int numsSize, int mid, int k) {
    int count = 0;
    int left = 0;
    int freq[100001] = {0};
    int distinct = 0;

    for (int right = 0; right < numsSize; right++) {
        freq[nums[right]]++;
        if (freq[nums[right]] == 1) {
            distinct++;
        }

        while (distinct > k) {
            freq[nums[left]]--;
            if (freq[nums[left]] == 0) {
                distinct--;
            }
            left++;
        }

        count += right - left + 1;
    }
    return count;
}

int medianOfUniquenessArray(int* nums, int numsSize) {
    long long total = (long long)numsSize * (numsSize + 1) / 2;
    long long target = (total + 1) / 2;

    int minUnique = 1;
    int maxUnique = 0;
    int seen[100001] = {0};
    for (int i = 0; i < numsSize; i++) {
        if (!seen[nums[i]]) {
            seen[nums[i]] = 1;
            maxUnique++;
        }
    }

    int left = 1, right = maxUnique;
    while (left < right) {
        int mid = left + (right - left) / 2;
        long long count = countLessEqual(nums, numsSize, mid, mid);

        if (count < target) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
}