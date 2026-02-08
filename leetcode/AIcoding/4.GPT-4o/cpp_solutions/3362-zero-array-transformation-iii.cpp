class Solution {
public:
    bool canTransform(vector<int>& arr) {
        int n = arr.size();
        unordered_map<int, int> count;
        for (int num : arr) {
            count[num]++;
        }

        for (auto& [num, cnt] : count) {
            if (num != 0 && cnt % 3 != 0) {
                return false;
            }
        }

        return true;
    }
};