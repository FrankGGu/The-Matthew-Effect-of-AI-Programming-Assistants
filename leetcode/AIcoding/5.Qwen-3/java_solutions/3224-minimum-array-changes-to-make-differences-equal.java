public class Solution {

import java.util.*;

public class Solution {
    public int minChanges(int[] nums, int k) {
        int n = nums.length;
        int[] freq = new int[1024];
        for (int num : nums) {
            freq[num]++;
        }

        int res = 0;
        for (int i = 0; i < k; i++) {
            int[] cnt = new int[1024];
            for (int j = i; j < n; j += k) {
                cnt[nums[j]]++;
            }

            int maxFreq = 0;
            for (int x = 0; x < 1024; x++) {
                maxFreq = Math.max(maxFreq, cnt[x]);
            }

            res += (n / k) - maxFreq;
        }

        return res;
    }
}
}