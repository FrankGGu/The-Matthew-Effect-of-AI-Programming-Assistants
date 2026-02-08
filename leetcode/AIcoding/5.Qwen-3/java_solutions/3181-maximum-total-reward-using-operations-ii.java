public class Solution {

import java.util.*;

public class Solution {
    public int maximumTotalReward = 0;

    public int maxTotal(int[] nums) {
        Arrays.sort(nums);
        Set<Integer> unique = new HashSet<>();
        for (int num : nums) {
            unique.add(num);
        }
        List<Integer> sortedUnique = new ArrayList<>(unique);
        Collections.sort(sortedUnique);
        int n = sortedUnique.size();
        boolean[] dp = new boolean[100001];
        dp[0] = true;
        for (int i = 0; i < n; i++) {
            int val = sortedUnique.get(i);
            for (int j = 100000 - val; j >= 0; j--) {
                if (dp[j] && j + val <= 100000) {
                    dp[j + val] = true;
                }
            }
        }
        for (int i = 100000; i >= 0; i--) {
            if (dp[i]) {
                return i;
            }
        }
        return 0;
    }

    public int maximumTotalReward(int[] nums) {
        return maxTotal(nums);
    }
}
}