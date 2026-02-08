public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> countSteppingNumbers(String low, String high) {
        List<Integer> result = new ArrayList<>();
        int lowNum = Integer.parseInt(low);
        int highNum = Integer.parseInt(high);
        for (int i = lowNum; i <= highNum; i++) {
            if (isSteppingNumber(i)) {
                result.add(i);
            }
        }
        return result;
    }

    private boolean isSteppingNumber(int num) {
        if (num < 10) {
            return true;
        }
        int prev = num % 10;
        num /= 10;
        while (num > 0) {
            int curr = num % 10;
            if (Math.abs(curr - prev) != 1) {
                return false;
            }
            prev = curr;
            num /= 10;
        }
        return true;
    }
}
}