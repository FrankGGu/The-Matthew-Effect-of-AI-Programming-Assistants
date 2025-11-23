class Solution {
public:
    int minNumberOfFlowers(vector<int>& arr) {
        unordered_map<int, int> count;
        for (int num : arr) {
            count[num]++;
        }

        int total = 0;
        for (auto& [key, value] : count) {
            total += (value + 1) / 2;
        }

        return total;
    }
};