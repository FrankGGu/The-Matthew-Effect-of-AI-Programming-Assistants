import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> findKDistantIndices(int[] nums, int key, int k) {
        List<Integer> result = new ArrayList<>();
        for (int i = 0; i < nums.length; i++) {
            if (Math.abs(i - findKeyIndex(nums, key)) <= k) {
                result.add(i);
            }
        }
        return result;
    }

    private int findKeyIndex(int[] nums, int key) {
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] == key) {
                return i;
            }
        }
        return -1; // key not found
    }
}