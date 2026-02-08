public class Solution {

import java.util.*;

public class Solution {
    public int[] closestDivisors(int num) {
        int[] result = new int[2];
        int minDiff = Integer.MAX_VALUE;

        for (int i = 1; i * i <= num + 2; i++) {
            if (num % i == 0) {
                int[] divisors = {i, num / i};
                int diff = divisors[1] - divisors[0];
                if (diff < minDiff) {
                    minDiff = diff;
                    result = divisors;
                }
            }
        }

        for (int i = 1; i * i <= num + 1; i++) {
            if ((num + 1) % i == 0) {
                int[] divisors = {i, (num + 1) / i};
                int diff = divisors[1] - divisors[0];
                if (diff < minDiff) {
                    minDiff = diff;
                    result = divisors;
                }
            }
        }

        return result;
    }
}
}