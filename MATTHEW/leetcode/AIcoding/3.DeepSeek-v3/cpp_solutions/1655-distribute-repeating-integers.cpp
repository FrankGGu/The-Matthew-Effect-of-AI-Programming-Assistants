class Solution {
public:
    bool canDistribute(vector<int>& nums, vector<int>& quantity) {
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }
        vector<int> counts;
        for (auto& [num, cnt] : freq) {
            counts.push_back(cnt);
        }
        sort(quantity.rbegin(), quantity.rend());
        return backtrack(counts, quantity, 0);
    }

private:
    bool backtrack(vector<int>& counts, vector<int>& quantity, int index) {
        if (index == quantity.size()) {
            return true;
        }
        for (int i = 0; i < counts.size(); ++i) {
            if (counts[i] >= quantity[index]) {
                counts[i] -= quantity[index];
                if (backtrack(counts, quantity, index + 1)) {
                    return true;
                }
                counts[i] += quantity[index];
            }
        }
        return false;
    }
};