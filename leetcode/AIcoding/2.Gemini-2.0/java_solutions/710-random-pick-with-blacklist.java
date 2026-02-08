import java.util.HashMap;
import java.util.Map;
import java.util.Random;

class Solution {
    private Map<Integer, Integer> map = new HashMap<>();
    private int bound;
    private Random rand = new Random();

    public Solution(int n, int[] blacklist) {
        bound = n - blacklist.length;
        for (int b : blacklist) {
            map.put(b, -1);
        }

        int w = bound;
        for (int b : blacklist) {
            if (b < bound) {
                while (map.containsKey(w)) {
                    w++;
                }
                map.put(b, w);
                w++;
            }
        }
    }

    public int pick() {
        int k = rand.nextInt(bound);
        return map.containsKey(k) ? map.get(k) : k;
    }
}