#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<vector<int>> findMatrix(vector<int>& nums) {
        unordered_map<int, int> counts;
        vector<vector<int>> result;

        for (int num : nums) {
            int count = counts[num];
            if (result.size() <= count) {
                result.push_back({});
            }
            result[count].push_back(num);
            counts[num]++;
        }

        return result;
    }
};