import java.util.LinkedList;

class MyHashMap {

    private static final int DEFAULT_CAPACITY = 10000;
    private LinkedList<Entry>[] buckets;

    private static class Entry {
        int key;
        int value;

        Entry(int key, int value) {
            this.key = key;
            this.value = value;
        }
    }

    public MyHashMap() {
        buckets = new LinkedList[DEFAULT_CAPACITY];
        for (int i = 0; i < DEFAULT_CAPACITY; i++) {
            buckets[i] = new LinkedList<>();
        }
    }

    private int hash(int key) {
        return key % DEFAULT_CAPACITY;
    }

    public void put(int key, int value) {
        int bucketIndex = hash(key);
        LinkedList<Entry> bucket = buckets[bucketIndex];

        for (Entry entry : bucket) {
            if (entry.key == key) {
                entry.value = value;
                return;
            }
        }
        bucket.add(new Entry(key, value));
    }

    public int get(int key) {
        int bucketIndex = hash(key);
        LinkedList<Entry> bucket = buckets[bucketIndex];

        for (Entry entry : bucket) {
            if (entry.key == key) {
                return entry.value;
            }
        }
        return -1;
    }

    public void remove(int key) {
        int bucketIndex = hash(key);
        LinkedList<Entry> bucket = buckets[bucketIndex];

        Entry toRemove = null;
        for (Entry entry : bucket) {
            if (entry.key == key) {
                toRemove = entry;
                break;
            }
        }
        if (toRemove != null) {
            bucket.remove(toRemove);
        }
    }
}