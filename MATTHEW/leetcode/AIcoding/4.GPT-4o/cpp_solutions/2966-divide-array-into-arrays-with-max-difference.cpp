class Solution {
public:
    bool canDivideArray(vector<int>& nums) {
        unordered_map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }
        for (auto& pair : count) {
            if (pair.second % 2 != 0) return false;
        }
        return true;
    }
};