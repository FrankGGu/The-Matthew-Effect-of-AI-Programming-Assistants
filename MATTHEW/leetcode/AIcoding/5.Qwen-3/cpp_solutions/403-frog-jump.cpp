#include <iostream>
#include <vector>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    bool canCross(vector<int>& stones) {
        if (stones[0] != 0 || stones[1] != 1) return false;
        unordered_map<int, unordered_set<int>> map;
        for (int i = 0; i < stones.size(); ++i) {
            map[stones[i]].insert(0);
        }
        for (int i = 0; i < stones.size(); ++i) {
            int pos = stones[i];
            for (int k : map[pos]) {
                for (int j = 1; j <= 2; ++j) {
                    int nextPos = pos + k + j;
                    if (map.find(nextPos) != map.end()) {
                        map[nextPos].insert(k + j);
                    }
                }
            }
        }
        return !map[stones.back()].empty();
    }
};