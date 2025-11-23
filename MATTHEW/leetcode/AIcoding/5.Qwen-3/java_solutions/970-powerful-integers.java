public class Solution {

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Solution {
    public List<Integer> powerfulIntegers(int x, int y, int maxSum) {
        Set<Integer> result = new HashSet<>();
        for (int i = 0; Math.pow(x, i) <= maxSum; i++) {
            for (int j = 0; Math.pow(y, j) <= maxSum; j++) {
                int sum = (int) (Math.pow(x, i) + Math.pow(y, j));
                if (sum <= maxSum) {
                    result.add(sum);
                }
            }
        }
        return new ArrayList<>(result);
    }
}
}