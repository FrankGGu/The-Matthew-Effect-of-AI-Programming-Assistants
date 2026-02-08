class MyHashMap {
private:
    static const int SIZE = 10007;
    vector<list<pair<int, int>>> table;

    int hash(int key) {
        return key % SIZE;
    }

public:
    MyHashMap() : table(SIZE) {}

    void put(int key, int value) {
        int index = hash(key);
        for (auto& it : table[index]) {
            if (it.first == key) {
                it.second = value;
                return;
            }
        }
        table[index].push_back({key, value});
    }

    int get(int key) {
        int index = hash(key);
        for (auto& it : table[index]) {
            if (it.first == key) {
                return it.second;
            }
        }
        return -1;
    }

    void remove(int key) {
        int index = hash(key);
        table[index].remove_if([key](const pair<int, int>& p) { return p.first == key; });
    }
};