class Solution {
public:
    int numPairsDivisibleBy60(vector<int>& time) {
        vector<int> remainder(60, 0);
        int count = 0;

        for (int t : time) {
            int r = t % 60;
            count += remainder[(60 - r) % 60];
            remainder[r]++;
        }

        return count;
    }
};