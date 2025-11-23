class Solution {
public:
    int numPairsDivisibleBy60(vector<int>& time) {
        vector<int> count(60, 0);
        int ans = 0;
        for (int t : time) {
            int r = t % 60;
            int complement = (60 - r) % 60;
            ans += count[complement];
            count[r]++;
        }
        return ans;
    }
};