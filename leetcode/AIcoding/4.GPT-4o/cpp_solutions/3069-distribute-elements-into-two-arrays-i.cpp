class Solution {
public:
    vector<vector<int>> distributeArray(vector<int>& nums) {
        unordered_map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }
        vector<int> arr1, arr2;
        for (auto& [num, cnt] : count) {
            int half = cnt / 2;
            for (int i = 0; i < half; i++) {
                arr1.push_back(num);
            }
            for (int i = 0; i < cnt - half; i++) {
                arr2.push_back(num);
            }
        }
        return {arr1, arr2};
    }
};