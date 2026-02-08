public class Solution {

import java.util.*;

public class Solution {
    public long minimumArrayEnd(int[] nums) {
        long result = 0;
        for (int num : nums) {
            result |= num;
        }
        return result;
    }
}
}