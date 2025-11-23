public class Solution {

import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<Integer> sequentialDigits(int n) {
        List<Integer> result = new ArrayList<>();
        for (int i = 1; i <= 9; i++) {
            int num = i;
            for (int j = i + 1; j <= 9; j++) {
                num = num * 10 + j;
                if (num <= n) {
                    result.add(num);
                }
            }
        }
        result.sort(null);
        return result;
    }
}
}