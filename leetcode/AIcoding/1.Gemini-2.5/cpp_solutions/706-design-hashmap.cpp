#include <vector>
#include <list>
#include <utility>

class MyHashMap {
private:
    int size;
    std::vector<std::list<std::pair<int, int>>> data;

    int hash(int key) {
        return key % size;
    }

public:
    MyHashMap() {
        size = 10007;
        data.resize(size);
    }

    void put(int key, int value) {
        int index = hash(key);
        for (auto& p : data[index]) {
            if (p.first == key) {
                p.second = value;
                return;
            }
        }
        data[index].push_back({key, value});
    }

    int get(int key) {
        int index = hash(key);
        for (const auto& p : data[index]) {
            if (p.first == key) {
                return p.second;
            }
        }
        return -1;
    }

    void remove(int key) {
        int index = hash(key);
        data[index].remove_if([key](const std::pair<int, int>& p) {
            return p.first == key;
        });
    }
};