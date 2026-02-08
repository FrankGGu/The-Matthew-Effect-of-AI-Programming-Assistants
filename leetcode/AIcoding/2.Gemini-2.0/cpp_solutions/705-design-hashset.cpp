class MyHashSet {
private:
    vector<bool> hashSet;
    int capacity;

public:
    MyHashSet() {
        capacity = 1000001;
        hashSet.resize(capacity, false);
    }

    void add(int key) {
        hashSet[key] = true;
    }

    void remove(int key) {
        hashSet[key] = false;
    }

    bool contains(int key) {
        return hashSet[key];
    }
};