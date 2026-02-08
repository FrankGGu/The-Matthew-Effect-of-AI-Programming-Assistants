int findMin(int* nums, int numsSize) {
    int left = 0;
    int right = numsSize - 1;

    while (left < right) {
        int mid = left + (right - left) / 2;

        if (nums[mid] < nums[right]) {
            right = mid;
        } else if (nums[mid] > nums[right]) {
            left = mid + 1;
        } else { // nums[mid] == nums[right]
            // If nums[mid] equals nums[right], we cannot determine if the minimum
            // is to the left or right of mid (or mid itself).
            // For example: [1,3,3] -> mid=1, right=2, nums[mid]=3, nums[right]=3. Min is 1.
            //              [3,1,3] -> mid=1, right=2, nums[mid]=1, nums[right]=3. Min is 1.
            // We can safely discard the rightmost element because it's a duplicate
            // and won't be the unique minimum if there are other smaller elements.
            // If it is the minimum, then nums[mid] (which is equal) would also be the minimum.
            right--;
        }
    }

    return nums[left];
}