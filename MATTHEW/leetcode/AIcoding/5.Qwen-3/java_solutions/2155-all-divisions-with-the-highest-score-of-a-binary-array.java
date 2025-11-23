public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> maxScoreIndices(int[] arr) {
        int leftZero = 0;
        int rightOne = 0;
        for (int num : arr) {
            if (num == 1) rightOne++;
        }
        int maxScore = 0;
        List<Integer> result = new ArrayList<>();
        for (int i = 0; i <= arr.length; i++) {
            int score = leftZero + rightOne;
            if (score > maxScore) {
                maxScore = score;
                result.clear();
                result.add(i);
            } else if (score == maxScore) {
                result.add(i);
            }
            if (i < arr.length) {
                if (arr[i] == 0) leftZero++;
                else rightOne--;
            }
        }
        return result;
    }
}
}