public class Solution {

import java.util.HashSet;
import java.util.Set;

public class Solution {
    public int distributeCandies(int[] candyType) {
        Set<Integer> uniqueCandies = new HashSet<>();
        for (int type : candyType) {
            uniqueCandies.add(type);
        }
        return Math.min(uniqueCandies.size(), candyType.length / 2);
    }
}
}