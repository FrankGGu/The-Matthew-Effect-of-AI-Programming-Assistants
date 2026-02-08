#include <vector>

using namespace std;

class Solution {
public:
    vector<int> findKDistantIndices(vector<int>& nums, int key, int k) {
        vector<int> result;
        vector<int> key_indices;
        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] == key) {
                key_indices.push_back(i);
            }
        }

        for (int i = 0; i < nums.size(); ++i) {
            for (int j : key_indices) {
                if (abs(i - j) <= k) {
                    result.push_back(i);
                    break;
                }
            }
        }

        return result;
    }
};