class Solution {
public:
    int minCost(vector<string>& captions, vector<int>& cost) {
        int n = captions.size();
        unordered_map<char, int> totalCost;
        unordered_map<char, int> count;

        for (int i = 0; i < n; ++i) {
            for (char c : captions[i]) {
                totalCost[c] += cost[i];
                count[c]++;
            }
        }

        int minCost = 0;
        for (char c = 'a'; c <= 'z'; ++c) {
            if (count[c] > 0) {
                minCost += totalCost[c] - (count[c] - 1) * minCost / count[c];
            }
        }

        return minCost;
    }
};