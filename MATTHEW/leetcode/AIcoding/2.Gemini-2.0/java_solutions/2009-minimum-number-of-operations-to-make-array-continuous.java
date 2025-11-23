import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

class Solution {
    public int minOperations(int[] nums) {
        int n = nums.length;
        Set<Integer> set = new HashSet<>();
        for (int num : nums) {
            set.add(num);
        }
        int[] uniqueNums = set.stream().mapToInt(Integer::intValue).toArray();
        Arrays.sort(uniqueNums);
        int uniqueLength = uniqueNums.length;
        int ans = n;
        int left = 0;
        for (int right = 0; right < uniqueLength; right++) {
            while (uniqueNums[right] - uniqueNums[left] >= n) {
                left++;
            }
            ans = Math.min(ans, n - (right - left + 1));
        }
        return ans;
    }
}