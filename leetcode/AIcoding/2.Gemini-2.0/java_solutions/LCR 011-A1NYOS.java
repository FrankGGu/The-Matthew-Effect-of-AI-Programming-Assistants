import java.util.HashMap;

class Solution {
    public int findMaxLength(int[] nums) {
        HashMap<Integer, Integer> countMap = new HashMap<>();
        countMap.put(0, -1);
        int maxLen = 0;
        int count = 0;
        for (int i = 0; i < nums.length; i++) {
            count += (nums[i] == 0) ? -1 : 1;
            if (countMap.containsKey(count)) {
                maxLen = Math.max(maxLen, i - countMap.get(count));
            } else {
                countMap.put(count, i);
            }
        }
        return maxLen;
    }
}