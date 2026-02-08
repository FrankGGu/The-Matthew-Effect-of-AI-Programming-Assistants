class Solution {
public:
    int minimumCost(string s) {
        int n = s.size();
        vector<int> freq(26, 0);
        for (char c : s) {
            freq[c - 'a']++;
        }

        int totalCost = INT_MAX;
        for (int i = 0; i < 26; i++) {
            if (freq[i] > 0) {
                int cost = 0;
                for (int j = 0; j < 26; j++) {
                    if (i != j) {
                        cost += freq[j];
                    }
                }
                totalCost = min(totalCost, cost);
            }
        }

        return totalCost;
    }
};