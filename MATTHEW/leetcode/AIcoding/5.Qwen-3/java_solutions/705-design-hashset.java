public class MyHashSet {
    private boolean[] storage;
    private int capacity;

    public MyHashSet() {
        capacity = 1000000;
        storage = new boolean[capacity];
    }

    public void add(int key) {
        if (key >= 0 && key < capacity) {
            storage[key] = true;
        }
    }

    public void remove(int key) {
        if (key >= 0 && key < capacity) {
            storage[key] = false;
        }
    }

    public boolean contains(int key) {
        return key >= 0 && key < capacity && storage[key];
    }
}