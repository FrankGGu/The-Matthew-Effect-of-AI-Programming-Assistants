import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashSet;

class AllOne {
    private HashMap<String, Integer> keyCount;
    private HashMap<Integer, LinkedHashSet<String>> countKeys;
    private int minCount, maxCount;

    public AllOne() {
        keyCount = new HashMap<>();
        countKeys = new HashMap<>();
        minCount = Integer.MAX_VALUE;
        maxCount = Integer.MIN_VALUE;
    }

    public void inc(String key) {
        int count = keyCount.getOrDefault(key, 0);
        keyCount.put(key, count + 1);
        if (count > 0) {
            countKeys.get(count).remove(key);
            if (countKeys.get(count).isEmpty()) {
                countKeys.remove(count);
                if (minCount == count) minCount++;
                if (maxCount == count) maxCount--;
            }
        }
        countKeys.putIfAbsent(count + 1, new LinkedHashSet<>());
        countKeys.get(count + 1).add(key);
        maxCount = Math.max(maxCount, count + 1);
        if (minCount == Integer.MAX_VALUE) minCount = count + 1;
    }

    public void dec(String key) {
        if (!keyCount.containsKey(key)) return;
        int count = keyCount.get(key);
        countKeys.get(count).remove(key);
        if (countKeys.get(count).isEmpty()) {
            countKeys.remove(count);
            if (minCount == count) minCount++;
            if (maxCount == count) maxCount--;
        }
        if (count == 1) {
            keyCount.remove(key);
        } else {
            keyCount.put(key, count - 1);
            countKeys.putIfAbsent(count - 1, new LinkedHashSet<>());
            countKeys.get(count - 1).add(key);
            minCount = Math.min(minCount, count - 1);
        }
    }

    public String getMaxKey() {
        return maxCount == Integer.MIN_VALUE ? "" : countKeys.get(maxCount).iterator().next();
    }

    public String getMinKey() {
        return minCount == Integer.MAX_VALUE ? "" : countKeys.get(minCount).iterator().next();
    }
}