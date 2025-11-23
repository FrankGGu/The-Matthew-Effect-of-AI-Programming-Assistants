public class Solution {

import java.util.*;

public class Solution {
    public int[] constructRectangle(int area) {
        int sqrt = (int) Math.sqrt(area);
        while (sqrt > 0) {
            if (area % sqrt == 0) {
                return new int[]{area / sqrt, sqrt};
            }
            sqrt--;
        }
        return new int[]{area, 1};
    }
}
}