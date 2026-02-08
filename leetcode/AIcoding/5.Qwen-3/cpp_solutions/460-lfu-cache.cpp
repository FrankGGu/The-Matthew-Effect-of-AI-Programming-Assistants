#include <iostream>
#include <vector>
#include <map>
#include <list>
#include <utility>

using namespace std;

class Solution {
private:
    int capacity;
    int minFreq;
    map<int, pair<int, int>> keyToValue;     map<int, list<int>> freqToList;
    map<int, list<int>::iterator> keyToIter;

public:
    Solution(int capacity) : capacity(capacity), minFreq(0) {}

    int get(int key) {
        if (keyToValue.find(key) == keyToValue.end()) {
            return -1;
        }
        int value = keyToValue[key].first;
        int freq = keyToValue[key].second;
        keyToValue[key].second++;
        freqToList[freq].erase(keyToIter[key]);
        if (freqToList[freq].empty() && minFreq == freq) {
            minFreq++;
        }
        freqToList[freq + 1].push_back(key);
        keyToIter[key] = --freqToList[freq + 1].end();
        return value;
    }

    void put(int key, int value) {
        if (capacity == 0) {
            return;
        }
        if (keyToValue.find(key) != keyToValue.end()) {
            keyToValue[key].first = value;
            int freq = keyToValue[key].second;
            keyToValue[key].second++;
            freqToList[freq].erase(keyToIter[key]);
            if (freqToList[freq].empty() && minFreq == freq) {
                minFreq++;
            }
            freqToList[freq + 1].push_back(key);
            keyToIter[key] = --freqToList[freq + 1].end();
            return;
        }
        if (keyToValue.size() >= capacity) {
            int evictKey = freqToList[minFreq].front();
            freqToList[minFreq].pop_front();
            keyToValue.erase(evictKey);
            keyToIter.erase(evictKey);
        }
        keyToValue[key] = {value, 1};
        freqToList[1].push_back(key);
        keyToIter[key] = --freqToList[1].end();
        minFreq = 1;
    }
};