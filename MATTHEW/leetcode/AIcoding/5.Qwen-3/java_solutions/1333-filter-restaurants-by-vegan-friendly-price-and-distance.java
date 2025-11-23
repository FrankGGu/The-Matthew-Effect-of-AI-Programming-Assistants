public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> filterRestaurants(int[][] restaurants, int veganFriendly, int maxPrice, int maxDistance) {
        List<List<Integer>> result = new ArrayList<>();
        for (int[] rest : restaurants) {
            if (veganFriendly == 1 && rest[2] == 0) continue;
            if (rest[3] > maxPrice) continue;
            if (rest[4] > maxDistance) continue;
            result.add(Arrays.asList(rest[0], rest[1]));
        }
        result.sort((a, b) -> b.get(1) - a.get(1));
        return result;
    }
}
}