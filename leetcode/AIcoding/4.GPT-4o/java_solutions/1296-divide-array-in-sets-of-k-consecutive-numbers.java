import java.util.Arrays;
import java.util.HashMap;

class Solution {
    public boolean isPossibleDivide(int[] nums, int k) {
        if (nums.length % k != 0) return false;
        Arrays.sort(nums);
        HashMap<Integer, Integer> countMap = new HashMap<>();
        for (int num : nums) {
            countMap.put(num, countMap.getOrDefault(num, 0) + 1);
        }
        for (int num : nums) {
            if (countMap.getOrDefault(num, 0) > 0) {
                for (int i = 0; i < k; i++) {
                    int nextNum = num + i;
                    if (countMap.getOrDefault(nextNum, 0) <= 0) return false;
                    countMap.put(nextNum, countMap.get(nextNum) - 1);
                }
            }
        }
        return true;
    }
}