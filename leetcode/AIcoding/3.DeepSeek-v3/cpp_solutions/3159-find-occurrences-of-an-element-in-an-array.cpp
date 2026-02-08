#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> occurrencesOfElement(vector<int>& nums, vector<int>& queries, int x) {
        unordered_map<int, vector<int>> indices;
        for (int i = 0; i < nums.size(); ++i) {
            indices[nums[i]].push_back(i);
        }
        vector<int> result;
        for (int q : queries) {
            if (indices[x].size() >= q) {
                result.push_back(indices[x][q - 1]);
            } else {
                result.push_back(-1);
            }
        }
        return result;
    }
};