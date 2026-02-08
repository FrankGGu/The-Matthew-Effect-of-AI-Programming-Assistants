class Solution {
public:
    int countCompleteDayPairs(vector<int>& hours) {
        unordered_map<int, int> freq;
        int count = 0;
        for (int hour : hours) {
            int mod = hour % 24;
            int complement = (24 - mod) % 24;
            if (freq.find(complement) != freq.end()) {
                count += freq[complement];
            }
            freq[mod]++;
        }
        return count;
    }
};