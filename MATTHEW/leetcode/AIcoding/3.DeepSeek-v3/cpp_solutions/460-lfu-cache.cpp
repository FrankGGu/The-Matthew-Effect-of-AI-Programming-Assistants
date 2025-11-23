#include <unordered_map>
#include <list>
using namespace std;

class LFUCache {
private:
    int capacity;
    int minFreq;
    unordered_map<int, int> keyToVal;
    unordered_map<int, int> keyToFreq;
    unordered_map<int, list<int>> freqToKeys;
    unordered_map<int, list<int>::iterator> keyToIter;

public:
    LFUCache(int capacity) {
        this->capacity = capacity;
        minFreq = 0;
    }

    int get(int key) {
        if (keyToVal.find(key) == keyToVal.end()) {
            return -1;
        }
        int freq = keyToFreq[key];
        freqToKeys[freq].erase(keyToIter[key]);
        if (freqToKeys[freq].empty()) {
            if (minFreq == freq) {
                minFreq++;
            }
        }
        freq++;
        keyToFreq[key] = freq;
        freqToKeys[freq].push_front(key);
        keyToIter[key] = freqToKeys[freq].begin();
        return keyToVal[key];
    }

    void put(int key, int value) {
        if (capacity <= 0) return;
        if (keyToVal.find(key) != keyToVal.end()) {
            keyToVal[key] = value;
            get(key);
            return;
        }
        if (keyToVal.size() >= capacity) {
            int delKey = freqToKeys[minFreq].back();
            freqToKeys[minFreq].pop_back();
            keyToVal.erase(delKey);
            keyToFreq.erase(delKey);
            keyToIter.erase(delKey);
        }
        keyToVal[key] = value;
        keyToFreq[key] = 1;
        freqToKeys[1].push_front(key);
        keyToIter[key] = freqToKeys[1].begin();
        minFreq = 1;
    }
};