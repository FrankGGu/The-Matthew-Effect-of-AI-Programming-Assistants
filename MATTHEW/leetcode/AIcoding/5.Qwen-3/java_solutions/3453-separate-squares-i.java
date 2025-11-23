public class Solution {

import java.util.*;

public class Solution {
    public int[] separateSquares(String s) {
        Set<Integer> squares = new HashSet<>();
        for (int i = 0; i <= 100000; i++) {
            squares.add(i * i);
        }

        List<Integer> result = new ArrayList<>();
        for (int i = 0; i < s.length(); i++) {
            if (squares.contains(Character.getNumericValue(s.charAt(i)))) {
                result.add(Character.getNumericValue(s.charAt(i)));
            }
        }

        int[] answer = new int[result.size()];
        for (int i = 0; i < answer.length; i++) {
            answer[i] = result.get(i);
        }
        return answer;
    }
}
}