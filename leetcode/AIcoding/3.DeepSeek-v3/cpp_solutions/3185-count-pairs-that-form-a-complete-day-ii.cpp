class Solution {
public:
    long long countCompleteDayPairs(vector<int>& hours) {
        unordered_map<int, int> freq;
        long long res = 0;
        for (int h : hours) {
            int mod = h % 24;
            int complement = (24 - mod) % 24;
            if (freq.count(complement)) {
                res += freq[complement];
            }
            freq[mod]++;
        }
        return res;
    }
};