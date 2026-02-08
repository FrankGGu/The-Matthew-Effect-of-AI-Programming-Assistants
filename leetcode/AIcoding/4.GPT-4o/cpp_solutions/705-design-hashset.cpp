class MyHashSet {
public:

    MyHashSet() {
        data.resize(1000);
    }

    void add(int key) {
        int index = key % 1000;
        if (find(data[index].begin(), data[index].end(), key) == data[index].end()) {
            data[index].push_back(key);
        }
    }

    void remove(int key) {
        int index = key % 1000;
        auto it = find(data[index].begin(), data[index].end(), key);
        if (it != data[index].end()) {
            data[index].erase(it);
        }
    }

    bool contains(int key) {
        int index = key % 1000;
        return find(data[index].begin(), data[index].end(), key) != data[index].end();
    }

private:
    vector<vector<int>> data;
};