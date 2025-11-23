import java.util.Arrays;

class Solution {
    public int maximizeGreatness(int[] nums) {
        Arrays.sort(nums);
        int greatness = 0;
        int p1 = 0; // Pointer for the element from nums (the one being compared against)

        // p2 is the loop variable, acting as a pointer for the element from perm
        for (int p2 = 0; p2 < nums.length; p2++) {
            // If nums[p2] is greater than nums[p1], we found a valid greatness pair.
            // This means we can assign nums[p2] to perm[p1]'s position.
            if (nums[p2] > nums[p1]) {
                greatness++;
                p1++; // Move to the next element in nums to find a match for.
            }
            // If nums[p2] <= nums[p1], nums[p2] cannot be used as a greater element for nums[p1].
            // We need to find a larger element for nums[p1], so we keep p1 at its current position
            // and advance p2 to look for a suitable candidate.
            // This is implicitly handled as p2 increments in the loop.
        }

        return greatness;
    }
}