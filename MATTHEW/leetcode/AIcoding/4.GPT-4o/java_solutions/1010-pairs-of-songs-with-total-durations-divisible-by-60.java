import java.util.HashMap;

public class Solution {
    public int numPairsDivisibleBy60(int[] time) {
        HashMap<Integer, Integer> map = new HashMap<>();
        int count = 0;

        for (int t : time) {
            int mod = t % 60;
            int complement = (60 - mod) % 60;
            count += map.getOrDefault(complement, 0);
            map.put(mod, map.getOrDefault(mod, 0) + 1);
        }

        return count;
    }
}