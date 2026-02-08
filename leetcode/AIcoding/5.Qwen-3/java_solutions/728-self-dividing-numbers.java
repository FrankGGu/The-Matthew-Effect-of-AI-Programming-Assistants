public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> selfDividingNumbers(int left, int right) {
        List<Integer> result = new ArrayList<>();
        for (int i = left; i <= right; i++) {
            if (isSelfDividing(i)) {
                result.add(i);
            }
        }
        return result;
    }

    private boolean isSelfDividing(int n) {
        int original = n;
        while (n > 0) {
            int digit = n % 10;
            if (digit == 0 || original % digit != 0) {
                return false;
            }
            n /= 10;
        }
        return true;
    }
}
}