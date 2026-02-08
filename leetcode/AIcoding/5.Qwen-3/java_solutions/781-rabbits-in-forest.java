public class Solution {

import java.util.*;

public class Solution {
    public int numRabbits(int[] answers) {
        Map<Integer, Integer> count = new HashMap<>();
        int result = 0;

        for (int answer : answers) {
            if (count.getOrDefault(answer, 0) == 0) {
                result += answer + 1;
                count.put(answer, answer);
            } else {
                count.put(answer, count.get(answer) - 1);
            }
        }

        return result;
    }
}
}