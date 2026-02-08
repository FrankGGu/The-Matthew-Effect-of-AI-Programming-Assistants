public class Solution {

import java.util.*;

public class Solution {
    public int sumOfSubsequencePower(int[] nums) {
        int mod = 1000000007;
        int n = nums.length;
        long result = 0;
        for (int i = 0; i < n; i++) {
            long power = 1;
            for (int j = i; j < n; j++) {
                power = (power * nums[j]) % mod;
                result = (result + power) % mod;
            }
        }
        return (int) result;
    }
}
}