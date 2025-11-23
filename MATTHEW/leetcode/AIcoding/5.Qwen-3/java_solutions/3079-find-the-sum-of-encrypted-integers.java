public class Solution {

import java.util.*;

public class Solution {
    public int sumOfEncryptedInt(int[] nums) {
        int sum = 0;
        for (int num : nums) {
            String s = String.valueOf(num);
            int length = s.length();
            int encrypted = 0;
            for (int i = 0; i < length; i++) {
                encrypted = encrypted * 10 + 9;
            }
            sum += encrypted;
        }
        return sum;
    }
}
}