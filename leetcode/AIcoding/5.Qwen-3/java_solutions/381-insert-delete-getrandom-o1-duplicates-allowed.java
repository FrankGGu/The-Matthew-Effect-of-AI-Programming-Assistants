public class Solution {

import java.util.*;

class RandomizedCollection {
    private Map<Integer, Set<Integer>> map;
    private List<Integer> list;
    private Random rand;

    public RandomizedCollection() {
        map = new HashMap<>();
        list = new ArrayList<>();
        rand = new Random();
    }

    public boolean insert(int val) {
        boolean contains = map.containsKey(val);
        if (!contains) {
            map.put(val, new HashSet<>());
        }
        map.get(val).add(list.size());
        list.add(val);
        return !contains;
    }

    public boolean remove(int val) {
        if (!map.containsKey(val)) {
            return false;
        }
        int index = map.get(val).iterator().next();
        int last = list.get(list.size() - 1);
        if (index != list.size() - 1) {
            list.set(index, last);
            map.get(last).remove(list.size() - 1);
            map.get(last).add(index);
        }
        map.get(val).remove(index);
        if (map.get(val).isEmpty()) {
            map.remove(val);
        }
        list.remove(list.size() - 1);
        return true;
    }

    public int getRandom() {
        return list.get(rand.nextInt(list.size()));
    }
}
}