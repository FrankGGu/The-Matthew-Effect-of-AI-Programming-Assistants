class Solution {
public:
    int garbageCollection(vector<string>& garbage, vector<int>& travel) {
        int n = garbage.size();
        int time = 0;
        int lastM = -1, lastP = -1, lastG = -1;

        for (int i = 0; i < n; ++i) {
            time += garbage[i].size();
            for (char c : garbage[i]) {
                if (c == 'M') lastM = i;
                else if (c == 'P') lastP = i;
                else if (c == 'G') lastG = i;
            }
        }

        vector<int> prefixSum(n, 0);
        for (int i = 1; i < n; ++i) {
            prefixSum[i] = prefixSum[i-1] + travel[i-1];
        }

        if (lastM > 0) time += prefixSum[lastM];
        if (lastP > 0) time += prefixSum[lastP];
        if (lastG > 0) time += prefixSum[lastG];

        return time;
    }
};