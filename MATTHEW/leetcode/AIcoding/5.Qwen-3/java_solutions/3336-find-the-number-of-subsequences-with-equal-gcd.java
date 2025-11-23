public class Solution {

import java.util.*;

public class Solution {
    public int numberOfSubsequences(int[] nums, int[] gcds) {
        Map<Integer, Integer> freq = new HashMap<>();
        for (int num : nums) {
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }

        int result = 0;
        for (int g : gcds) {
            int count = 0;
            for (int key : freq.keySet()) {
                if (gcd(key, g) == g) {
                    count += freq.get(key);
                }
            }
            result += count;
        }
        return result;
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