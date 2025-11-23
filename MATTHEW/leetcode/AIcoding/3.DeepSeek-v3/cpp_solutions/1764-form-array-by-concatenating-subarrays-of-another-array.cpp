class Solution {
public:
    bool canChoose(vector<vector<int>>& groups, vector<int>& nums) {
        int i = 0;
        for (const auto& group : groups) {
            bool found = false;
            for (int j = i; j + group.size() <= nums.size(); ++j) {
                if (equal(group.begin(), group.end(), nums.begin() + j)) {
                    i = j + group.size();
                    found = true;
                    break;
                }
            }
            if (!found) return false;
        }
        return true;
    }
};