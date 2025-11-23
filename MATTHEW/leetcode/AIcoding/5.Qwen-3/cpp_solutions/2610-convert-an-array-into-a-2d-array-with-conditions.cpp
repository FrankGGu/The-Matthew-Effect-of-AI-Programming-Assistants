#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    vector<vector<int>> find2DArray(vector<int>& nums) {
        map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }

        vector<vector<int>> result;
        while (!count.empty()) {
            vector<int> row;
            for (auto it = count.begin(); it != count.end();) {
                row.push_back(it->first);
                if (--it->second == 0) {
                    it = count.erase(it);
                } else {
                    ++it;
                }
            }
            result.push_back(row);
        }

        return result;
    }
};