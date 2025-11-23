import java.util.Random;
import java.util.HashMap;
import java.util.HashSet;

class Solution {
    private HashMap<Integer, Integer> map;
    private Random rand;
    private int effectiveSize;

    public Solution(int n, int[] blacklist) {
        map = new HashMap<>();
        rand = new Random();
        effectiveSize = n - blacklist.length;

        HashSet<Integer> blacklistSet = new HashSet<>();
        for (int b : blacklist) {
            blacklistSet.add(b);
        }

        int lastValidNum = n - 1;

        for (int b : blacklist) {
            if (b < effectiveSize) {
                while (blacklistSet.contains(lastValidNum)) {
                    lastValidNum--;
                }
                map.put(b, lastValidNum);
                lastValidNum--;
            }
        }
    }

    public int pick() {
        int index = rand.nextInt(effectiveSize);

        if (map.containsKey(index)) {
            return map.get(index);
        } else {
            return index;
        }
    }
}