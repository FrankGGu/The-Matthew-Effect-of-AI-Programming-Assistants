class Solution {
public:
    int maximumNetworkQuality(vector<vector<int>>& coordinates, int k) {
        int n = coordinates.size();
        vector<int> quality(n);
        vector<int> totalQuality(n, 0);

        for (int i = 0; i < n; i++) {
            totalQuality[i] = coordinates[i][0] + coordinates[i][1];
            quality[i] = coordinates[i][2];
        }

        sort(totalQuality.begin(), totalQuality.end(), greater<int>());

        int maxQuality = 0;

        for (int i = 0; i < min(k, n); i++) {
            maxQuality += quality[i];
        }

        return maxQuality;
    }
};