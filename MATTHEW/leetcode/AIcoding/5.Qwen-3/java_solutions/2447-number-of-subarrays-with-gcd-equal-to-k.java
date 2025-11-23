public class Solution {

import java.util.*;

public class Solution {
    public int numSubarraysWithGCDEqualtoK(int[] nums, int k) {
        int count = 0;
        for (int i = 0; i < nums.length; i++) {
            int currentGCD = nums[i];
            if (currentGCD == k) count++;
            for (int j = i + 1; j < nums.length; j++) {
                currentGCD = gcd(currentGCD, nums[j]);
                if (currentGCD == k) count++;
                else if (currentGCD < k) break;
            }
        }
        return count;
    }

    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}
}