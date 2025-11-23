class MyHashSet {
private:
    static const int MAX_KEY = 1000001;
    bool data[MAX_KEY];

public:
    MyHashSet() {
        std::fill(data, data + MAX_KEY, false);
    }

    void add(int key) {
        if (key >= 0 && key < MAX_KEY) {
            data[key] = true;
        }
    }

    void remove(int key) {
        if (key >= 0 && key < MAX_KEY) {
            data[key] = false;
        }
    }

    bool contains(int key) {
        if (key >= 0 && key < MAX_KEY) {
            return data[key];
        }
        return false;
    }
};