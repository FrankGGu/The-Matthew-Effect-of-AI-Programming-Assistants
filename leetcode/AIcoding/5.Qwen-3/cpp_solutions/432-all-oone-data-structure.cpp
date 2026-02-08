#include <iostream>
#include <vector>
#include <map>
#include <set>
#include <unordered_map>

using namespace std;

class Solution {
private:
    map<int, set<string>> buckets;
    unordered_map<string, int> keyCount;
    int minCount;

public:
    Solution() : minCount(0) {}

    void inc(string key) {
        if (keyCount.find(key) == keyCount.end()) {
            keyCount[key] = 1;
            buckets[1].insert(key);
            if (minCount == 0 || 1 < minCount) {
                minCount = 1;
            }
        } else {
            int currentCount = keyCount[key];
            buckets[currentCount].erase(key);
            if (buckets[currentCount].empty()) {
                buckets.erase(currentCount);
                if (currentCount == minCount) {
                    minCount++;
                }
            }
            keyCount[key] = currentCount + 1;
            buckets[currentCount + 1].insert(key);
        }
    }

    void dec(string key) {
        if (keyCount.find(key) == keyCount.end()) {
            return;
        }

        int currentCount = keyCount[key];
        buckets[currentCount].erase(key);
        if (buckets[currentCount].empty()) {
            buckets.erase(currentCount);
            if (currentCount == minCount) {
                minCount++;
            }
        }

        if (currentCount == 1) {
            keyCount.erase(key);
        } else {
            keyCount[key] = currentCount - 1;
            buckets[currentCount - 1].insert(key);
        }
    }

    string getMaxKey() {
        if (buckets.empty()) {
            return "";
        }
        return *buckets.rbegin()->second.begin();
    }

    string getMinKey() {
        if (buckets.empty()) {
            return "";
        }
        return *buckets.begin()->second.begin();
    }
};