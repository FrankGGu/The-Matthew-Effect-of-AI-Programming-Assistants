public class Solution {

import java.util.*;

public class Solution {
    public int numSubarrayLCM(int[] nums, int k) {
        int count = 0;
        for (int i = 0; i < nums.length; i++) {
            int currentLCM = nums[i];
            if (currentLCM == k) count++;
            for (int j = i + 1; j < nums.length; j++) {
                currentLCM = lcm(currentLCM, nums[j]);
                if (currentLCM == k) count++;
                else if (currentLCM > k) break;
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

    private int lcm(int a, int b) {
        return a * b / gcd(a, b);
    }
}
}