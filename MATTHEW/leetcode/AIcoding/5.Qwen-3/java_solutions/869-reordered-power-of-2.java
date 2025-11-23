public class Solution {

import java.util.Arrays;

public class Solution {
    public boolean reorderedPowerOf2(int n) {
        char[] digits = String.valueOf(n).toCharArray();
        Arrays.sort(digits);
        for (int i = 0; i < 31; i++) {
            char[] powerOfTwo = String.valueOf(1 << i).toCharArray();
            Arrays.sort(powerOfTwo);
            if (Arrays.equals(digits, powerOfTwo)) {
                return true;
            }
        }
        return false;
    }
}
}