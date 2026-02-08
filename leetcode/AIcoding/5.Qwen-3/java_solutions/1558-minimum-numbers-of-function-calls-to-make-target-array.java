public class Solution {

import java.util.*;

public class Solution {
    public int numberOfFunctions(int[] target) {
        int result = 0;
        int[] current = new int[target.length];

        while (!Arrays.equals(current, target)) {
            boolean hasIncrement = false;
            for (int i = 0; i < target.length; i++) {
                if (current[i] < target[i]) {
                    current[i]++;
                    result++;
                    hasIncrement = true;
                }
            }
            if (!hasIncrement) {
                for (int i = 0; i < target.length; i++) {
                    if (current[i] > 0) {
                        current[i]--;
                        result++;
                    }
                }
            }
        }
        return result;
    }
}
}