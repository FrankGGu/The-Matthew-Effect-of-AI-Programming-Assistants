class Solution {
public:
    int minimumOperations(vector<int>& nums) {
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }

        vector<int> counts;
        for (auto& [num, count] : freq) {
            counts.push_back(count);
        }

        sort(counts.rbegin(), counts.rend());
        int operations = 0, total = 0;

        for (int count : counts) {
            if (total >= nums.size() / 2) break;
            total += count;
            operations++;
        }

        return operations;
    }
};