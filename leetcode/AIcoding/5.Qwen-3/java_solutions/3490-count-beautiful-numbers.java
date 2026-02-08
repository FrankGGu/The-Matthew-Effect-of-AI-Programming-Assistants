public class Solution {

import java.util.*;

public class Solution {
    public int numberOfBeautifulIntegers(int[] nums) {
        int count = 0;
        for (int num : nums) {
            String s = String.valueOf(num);
            int n = s.length();
            if (n % 2 != 0) continue;
            int half = n / 2;
            String firstHalf = s.substring(0, half);
            String secondHalf = s.substring(half);
            if (firstHalf.equals(secondHalf)) {
                count++;
            }
        }
        return count;
    }
}
}