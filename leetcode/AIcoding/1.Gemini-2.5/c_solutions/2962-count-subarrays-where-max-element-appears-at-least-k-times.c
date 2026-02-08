long long countSubarrays(int* nums, int numsSize, int k) {
    if (numsSize == 0) {
        return 0;
    }

    int max_val = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max_val) {
            max_val = nums[i];
        }
    }

    long long ans = 0;
    int left = 0;
    int count = 0; 

    for (int right = 0; right < numsSize; right++) {
        if (nums[right] == max_val) {
            count++;
        }

        while (count >= k) {
            ans += (numsSize - right); 
            if (nums[left] == max_val) {
                count--;
            }
            left++;
        }
    }
    return ans;
}