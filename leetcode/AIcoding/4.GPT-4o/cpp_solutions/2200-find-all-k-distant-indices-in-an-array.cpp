class Solution {
public:
    vector<int> findKDistantIndices(vector<int>& nums, int key, int k) {
        vector<int> result;
        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] == key) {
                for (int j = max(0, i - k); j <= min((int)nums.size() - 1, i + k); ++j) {
                    result.push_back(j);
                }
            }
        }
        sort(result.begin(), result.end());
        result.erase(unique(result.begin(), result.end()), result.end());
        return result;
    }
};