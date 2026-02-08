public class Solution {

import java.util.*;

public class Solution {
    public int[] countBoxes(int[] apple, int[] capacity) {
        Arrays.sort(apple);
        Arrays.sort(capacity);
        int[] result = new int[apple.length];
        int index = 0;
        int i = apple.length - 1;
        int j = capacity.length - 1;
        while (i >= 0 && j >= 0) {
            if (apple[i] <= capacity[j]) {
                result[index++] = capacity[j];
                j--;
                i--;
            } else {
                j--;
            }
        }
        return Arrays.copyOf(result, index);
    }
}
}