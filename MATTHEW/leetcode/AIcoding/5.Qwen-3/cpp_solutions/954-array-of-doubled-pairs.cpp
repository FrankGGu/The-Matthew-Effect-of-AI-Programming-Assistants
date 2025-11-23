#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    bool canReorderArray(vector<int>& arr) {
        map<int, int> count;
        for (int num : arr) {
            count[num]++;
        }

        for (auto& [num, _] : count) {
            if (count[num] == 0) continue;
            if (num == 0) {
                if (count[num] % 2 != 0) return false;
                continue;
            }
            if (count[num * 2] < count[num]) return false;
            count[num * 2] -= count[num];
        }
        return true;
    }
};