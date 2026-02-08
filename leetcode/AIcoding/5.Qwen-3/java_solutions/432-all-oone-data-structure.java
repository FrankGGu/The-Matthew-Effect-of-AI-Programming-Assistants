public class Solution {

import java.util.*;

public class AllOne {
    private Map<String, Integer> keyCountMap;
    private Map<Integer, Set<String>> countKeysMap;
    private int minCount;

    public AllOne() {
        keyCountMap = new HashMap<>();
        countKeysMap = new HashMap<>();
        minCount = 1;
    }

    public void inc(String key) {
        int count = keyCountMap.getOrDefault(key, 0);
        if (count > 0) {
            countKeysMap.get(count).remove(key);
            if (countKeysMap.get(count).isEmpty()) {
                countKeysMap.remove(count);
                if (minCount == count) {
                    minCount++;
                }
            }
        }

        count++;
        keyCountMap.put(key, count);
        countKeysMap.putIfAbsent(count, new HashSet<>());
        countKeysMap.get(count).add(key);
    }

    public void dec(String key) {
        int count = keyCountMap.getOrDefault(key, 0);
        if (count == 0) {
            return;
        }

        countKeysMap.get(count).remove(key);
        if (countKeysMap.get(count).isEmpty()) {
            countKeysMap.remove(count);
            if (minCount == count) {
                minCount++;
            }
        }

        if (count > 1) {
            count--;
            keyCountMap.put(key, count);
            countKeysMap.putIfAbsent(count, new HashSet<>());
            countKeysMap.get(count).add(key);
        } else {
            keyCountMap.remove(key);
        }
    }

    public String getMaxKey() {
        if (countKeysMap.isEmpty()) {
            return "";
        }
        int maxCount = Collections.max(countKeysMap.keySet());
        return countKeysMap.get(maxCount).iterator().next();
    }

    public String getMinKey() {
        if (countKeysMap.isEmpty()) {
            return "";
        }
        return countKeysMap.get(minCount).iterator().next();
    }
}
}