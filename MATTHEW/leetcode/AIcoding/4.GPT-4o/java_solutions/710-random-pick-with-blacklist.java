import java.util.HashMap;
import java.util.Map;
import java.util.Random;

class Solution {
    private final int w;
    private final Map<Integer, Integer> map;
    private final Random random;

    public Solution(int N, int[] blacklist) {
        this.w = N - blacklist.length;
        this.map = new HashMap<>();
        this.random = new Random();

        for (int b : blacklist) {
            if (b >= w) {
                map.put(b, 0);
            }
        }

        int last = N - 1;
        for (int b : blacklist) {
            if (b < w) {
                while (map.containsKey(last)) {
                    last--;
                }
                map.put(b, last);
                last--;
            }
        }
    }

    public int pick() {
        int idx = random.nextInt(w);
        return map.getOrDefault(idx, idx);
    }
}