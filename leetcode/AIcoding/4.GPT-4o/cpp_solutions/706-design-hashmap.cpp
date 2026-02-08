class MyHashMap {
public:
    vector<int> keys;
    vector<int> values;

    MyHashMap() {
        keys.resize(1000001, -1);
    }

    void put(int key, int value) {
        keys[key] = value;
    }

    int get(int key) {
        return keys[key] == -1 ? -1 : keys[key];
    }

    void remove(int key) {
        keys[key] = -1;
    }
};