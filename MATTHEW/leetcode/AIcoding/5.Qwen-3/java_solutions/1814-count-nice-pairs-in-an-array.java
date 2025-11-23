public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int countNicePairs(int[] nums) {
        Map<Integer, Integer> map = new HashMap<>();
        int mod = 1000000007;
        int count = 0;
        for (int num : nums) {
            int rev = 0;
            int n = num;
            while (n > 0) {
                rev = rev * 10 + n % 10;
                n /= 10;
            }
            count = (count + map.getOrDefault(num - rev, 0)) % mod;
            map.put(num - rev, map.getOrDefault(num - rev, 0) + 1);
        }
        return count;
    }
}
}