import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;

class LRUCache {

    private int capacity;
    private Map<Integer, Integer> cache;
    private LinkedList<Integer> list;

    public LRUCache(int capacity) {
        this.capacity = capacity;
        this.cache = new HashMap<>();
        this.list = new LinkedList<>();
    }

    public int get(int key) {
        if (cache.containsKey(key)) {
            list.remove((Integer) key);
            list.addFirst(key);
            return cache.get(key);
        }
        return -1;
    }

    public void put(int key, int value) {
        if (cache.containsKey(key)) {
            list.remove((Integer) key);
        } else {
            if (cache.size() == capacity) {
                int last = list.removeLast();
                cache.remove(last);
            }
        }
        list.addFirst(key);
        cache.put(key, value);
    }
}