public class Solution {

import java.util.HashSet;
import java.util.Set;

public class Solution {
    public int countDistinctColors(int[][] balls) {
        Set<Integer> colors = new HashSet<>();
        for (int[] ball : balls) {
            colors.add(ball[0]);
        }
        return colors.size();
    }
}
}