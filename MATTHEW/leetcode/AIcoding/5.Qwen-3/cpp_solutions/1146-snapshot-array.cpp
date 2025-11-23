#include <iostream>
#include <vector>
#include <map>
#include <algorithm>

using namespace std;

class Solution {
private:
    vector<map<int, int>> snapMap;
    int currentSnapId;

public:
    Solution(int length) {
        snapMap.resize(length);
        currentSnapId = 0;
        for (int i = 0; i < length; ++i) {
            snapMap[i][0] = 0;
        }
    }

    void set(int index, int value) {
        snapMap[index][currentSnapId] = value;
    }

    int snap() {
        return currentSnapId++;
    }

    int get(int index, int snapId) {
        auto& map = snapMap[index];
        auto it = map.find(snapId);
        if (it != map.end()) {
            return it->second;
        }
                it = map.upper_bound(snapId);
        if (it == map.begin()) {
            return 0;
        }
        --it;
        return it->second;
    }
};