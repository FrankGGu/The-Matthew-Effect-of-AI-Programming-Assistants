public class Solution {

import java.util.*;

public class Solution {
    public boolean xorGame(int[] nums) {
        int xorSum = 0;
        for (int num : nums) {
            xorSum ^= num;
        }
        return xorSum == 0;
    }
}
}