public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> powerfulIntegers(int x, int y, int bound) {
        Set<Integer> result = new HashSet<>();
        for (int i = 0; i <= 100; i++) {
            for (int j = 0; j <= 100; j++) {
                int val = (int) Math.pow(x, i) + (int) Math.pow(y, j);
                if (val <= bound) {
                    result.add(val);
                } else {
                    break;
                }
            }
        }
        return new ArrayList<>(result);
    }
}
}