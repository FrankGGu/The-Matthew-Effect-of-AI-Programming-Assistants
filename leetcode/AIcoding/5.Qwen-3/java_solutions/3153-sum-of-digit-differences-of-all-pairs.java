public class Solution {

import java.util.*;

public class Solution {
    public int sumOfDigitDifferences(int[] nums) {
        int n = nums.length;
        int result = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int a = nums[i];
                int b = nums[j];
                int diff = 0;
                while (a > 0 || b > 0) {
                    int digitA = a % 10;
                    int digitB = b % 10;
                    if (digitA != digitB) {
                        diff++;
                    }
                    a /= 10;
                    b /= 10;
                }
                result += diff;
            }
        }
        return result;
    }
}
}