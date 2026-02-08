import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public int numberOfPoints(List<List<Integer>> nums) {
        List<Integer> points = new ArrayList<>();
        for (List<Integer> num : nums) {
            for (int i = num.get(0); i <= num.get(1); i++) {
                if (!points.contains(i)) {
                    points.add(i);
                }
            }
        }
        return points.size();
    }
}