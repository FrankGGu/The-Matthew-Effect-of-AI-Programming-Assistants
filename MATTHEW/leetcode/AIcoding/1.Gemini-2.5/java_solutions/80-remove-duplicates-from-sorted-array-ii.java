class Solution {
    public int removeDuplicates(int[] nums) {
        if (nums.length <= 2) {
            return nums.length;
        }

        int k = 2; // k is the pointer for the next position to fill, starting after the first two elements

        // Iterate from the third element
        for (int i = 2; i < nums.length; i++) {
            // If the current element is different from the element at k-2 (which is the element
            // that would be the first of a potential triplet of duplicates if nums[i] was equal),
            // then we can include nums[i].
            if (nums[i] != nums[k - 2]) {
                nums[k] = nums[i];
                k++;
            }
        }

        return k;
    }
}