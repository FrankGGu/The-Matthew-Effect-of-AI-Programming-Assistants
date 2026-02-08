class MyHashSet {
    private boolean[] data;
    private final int MAX_KEY = 1000000;

    public MyHashSet() {
        data = new boolean[MAX_KEY + 1];
    }

    public void add(int key) {
        if (key >= 0 && key <= MAX_KEY) {
            data[key] = true;
        }
    }

    public void remove(int key) {
        if (key >= 0 && key <= MAX_KEY) {
            data[key] = false;
        }
    }

    public boolean contains(int key) {
        if (key >= 0 && key <= MAX_KEY) {
            return data[key];
        }
        return false;
    }
}