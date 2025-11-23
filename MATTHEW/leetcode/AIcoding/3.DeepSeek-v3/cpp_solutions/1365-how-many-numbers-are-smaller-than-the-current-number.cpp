class Solution {
public:
    vector<int> smallerNumbersThanCurrent(vector<int>& nums) {
        vector<int> sorted = nums;
        sort(sorted.begin(), sorted.end());
        unordered_map<int, int> count;
        for (int i = 0; i < sorted.size(); ++i) {
            if (count.find(sorted[i]) == count.end()) {
                count[sorted[i]] = i;
            }
        }
        vector<int> result;
        for (int num : nums) {
            result.push_back(count[num]);
        }
        return result;
    }
};