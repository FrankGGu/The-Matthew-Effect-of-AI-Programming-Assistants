public class Solution {

import java.util.*;

public class Solution {
    public boolean hasTrailingZeros(int[] nums) {
        int orResult = 0;
        for (int num : nums) {
            orResult |= num;
        }
        return (orResult & 1) == 0;
    }
}
}