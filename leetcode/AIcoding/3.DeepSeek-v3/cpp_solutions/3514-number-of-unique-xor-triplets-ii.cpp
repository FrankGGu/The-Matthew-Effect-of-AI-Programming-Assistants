class Solution {
public:
    int countTriplets(vector<int>& nums) {
        unordered_map<int, int> freq;
        for (int a : nums) {
            for (int b : nums) {
                freq[a & b]++;
            }
        }
        int res = 0;
        for (int c : nums) {
            for (auto& [ab, cnt] : freq) {
                if ((ab & c) == 0) {
                    res += cnt;
                }
            }
        }
        return res;
    }
};