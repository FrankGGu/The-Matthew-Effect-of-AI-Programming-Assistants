import java.util.TreeMap;

class Solution {
    public long sumOfSquares(int[] nums) {
        long ans = 0;
        long last = 0;
        TreeMap<Integer, Integer> map = new TreeMap<>();
        long total = 0;

        for (int num : nums) {
            TreeMap<Integer, Integer> updates = new TreeMap<>();
            int add = num;
            while (add > 0) {
                Integer floorKey = map.floorKey(add);
                if (floorKey != null) {
                    int val = map.get(floorKey);
                    if (floorKey == add) {
                        total -= (long) add * val;
                        updates.put(add, updates.getOrDefault(add, 0) + val);
                        map.remove(add);
                        add = 0;
                    } else {
                        total -= (long) floorKey * val;
                        updates.put(floorKey, updates.getOrDefault(floorKey, 0) + val);
                        map.remove(floorKey);
                        add -= floorKey;
                    }
                } else {
                    break;
                }
            }
            map.put(num, map.getOrDefault(num, 0) + 1);
            total += (long) num;

            long current = total;
            for (int key : updates.keySet()) {
                map.put(key, map.getOrDefault(key, 0) + updates.get(key));
            }

            ans += current * current;
        }

        return ans;
    }
}