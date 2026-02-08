#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> relocateMarbles(vector<int>& marbles, int moveFrom, int moveTo) {
        unordered_set<int> set(marbles.begin(), marbles.end());
        if (set.count(moveFrom) == 0) {
            return marbles;
        }
        set.erase(moveFrom);
        set.insert(moveTo);
        vector<int> result(set.begin(), set.end());
        return result;
    }
};