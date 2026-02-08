import java.util.HashSet;
import java.util.Set;

class Solution {

    public boolean twoSumTarget(int[] prices, int target) {
        Set<Integer> seen = new HashSet<>();
        for (int price : prices) {
            if (seen.contains(target - price)) {
                return true;
            }
            seen.add(price);
        }
        return false;
    }
}