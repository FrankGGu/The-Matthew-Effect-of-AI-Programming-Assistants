import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public List<Integer> sequentialDigits(int low, int high) {
        List<Integer> result = new ArrayList<>();

        for (int i = 1; i <= 9; i++) {
            int currentNum = i;
            for (int j = i + 1; j <= 9; j++) {
                currentNum = currentNum * 10 + j;
                if (currentNum >= low && currentNum <= high) {
                    result.add(currentNum);
                }
                if (currentNum > high) {
                    break;
                }
            }
        }
        Collections.sort(result);
        return result;
    }
}