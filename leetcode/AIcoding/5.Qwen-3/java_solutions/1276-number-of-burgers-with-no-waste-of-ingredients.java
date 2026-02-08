public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> findNoWasteBurgers(int totalHamburgers, int totalTomatoSlices, int totalCheeseSlices) {
        List<List<Integer>> result = new ArrayList<>();
        int x = (totalTomatoSlices - 2 * totalCheeseSlices) / 2;
        int y = totalCheeseSlices - x;
        if (2 * x + 2 * y == totalHamburgers && 2 * x + 4 * y == totalTomatoSlices && x >= 0 && y >= 0) {
            List<Integer> burger = new ArrayList<>();
            burger.add(x);
            burger.add(y);
            result.add(burger);
        }
        return result;
    }
}
}