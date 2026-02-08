public class Solution {

import java.util.*;

public class Solution {
    public int[] shortestImpossibleSequence(int[] rolls) {
        int[] result = new int[0];
        int count = 0;
        Set<Integer> set = new HashSet<>();
        for (int roll : rolls) {
            if (!set.contains(roll)) {
                set.add(roll);
                count++;
                if (count == 1) {
                    result = new int[1];
                    result[0] = 1;
                } else {
                    int[] temp = new int[count];
                    for (int i = 0; i < count; i++) {
                        temp[i] = i + 1;
                    }
                    result = temp;
                }
            }
        }
        return result;
    }
}
}