public class Solution {

import java.util.*;

public class Solution {
    public int[] minOperations(String boxes) {
        int n = boxes.length();
        int[] result = new int[n];
        int leftCount = 0, rightCount = 0;
        int leftSum = 0, rightSum = 0;

        for (int i = 0; i < n; i++) {
            if (boxes.charAt(i) == '1') {
                leftCount++;
                leftSum += i;
            }
        }

        result[0] = leftSum;

        for (int i = 1; i < n; i++) {
            if (boxes.charAt(i - 1) == '1') {
                leftCount--;
                leftSum--;
            }
            result[i] = result[i - 1] - leftCount;
        }

        for (int i = n - 2; i >= 0; i--) {
            if (boxes.charAt(i + 1) == '1') {
                rightCount++;
                rightSum += (n - 1 - i);
            }
            result[i] += rightSum;
        }

        return result;
    }
}
}