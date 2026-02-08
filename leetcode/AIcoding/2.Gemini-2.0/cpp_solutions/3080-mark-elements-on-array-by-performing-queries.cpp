#include <vector>

using namespace std;

class Solution {
public:
    vector<int> markElements(vector<int>& nums, vector<vector<int>>& queries) {
        int n = nums.size();
        vector<int> marked(n, 0);
        for (auto& query : queries) {
            int type = query[0];
            int index = query[1];
            if (type == 1) {
                if (marked[index] == 0) {
                    marked[index] = 1;
                }
            } else {
                int val = query[2];
                for (int i = 0; i < n; ++i) {
                    if (nums[i] == val && marked[i] == 0) {
                        marked[i] = 1;
                        break;
                    }
                }
            }
        }
        return marked;
    }
};