public class Solution {

import java.util.*;

public class Solution {
    private Map<Integer, Integer> map;
    private int size;
    private Random random;

    public Solution(int n, int[] blacklist) {
        map = new HashMap<>();
        size = n - blacklist.length;
        random = new Random();

        for (int b : blacklist) {
            map.put(b, 0);
        }

        int last = n - 1;
        for (int b : blacklist) {
            if (b >= size) {
                continue;
            }
            while (map.containsKey(last)) {
                last--;
            }
            map.put(b, last);
            last--;
        }
    }

    public int pick() {
        int r = random.nextInt(size);
        return map.getOrDefault(r, r);
    }
}
}