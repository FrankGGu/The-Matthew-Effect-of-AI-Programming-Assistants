#include <unordered_map>
#include <list>
#include <utility>

class LFUCache {
public:
    LFUCache(int capacity) : capacity(capacity), minFreq(0) {}

    int get(int key) {
        if (capacity == 0 || keyFreq.find(key) == keyFreq.end()) return -1;
        update(key);
        return keyValue[key];
    }

    void put(int key, int value) {
        if (capacity == 0) return;
        if (keyFreq.find(key) != keyFreq.end()) {
            keyValue[key] = value;
            update(key);
        } else {
            if (keyValue.size() >= capacity) {
                auto it = freqList[minFreq].back();
                freqList[minFreq].pop_back();
                keyValue.erase(it);
                keyFreq.erase(it);
            }
            keyValue[key] = value;
            keyFreq[key] = 1;
            minFreq = 1;
            freqList[1].push_front(key);
        }
    }

private:
    int capacity, minFreq;
    std::unordered_map<int, int> keyValue;
    std::unordered_map<int, int> keyFreq;
    std::unordered_map<int, std::list<int>> freqList;

    void update(int key) {
        int freq = keyFreq[key];
        keyFreq[key]++;
        freqList[freq].remove(key);
        if (freqList[freq].empty() && minFreq == freq) {
            minFreq++;
        }
        freqList[freq + 1].push_front(key);
    }
};