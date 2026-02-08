class Solution {
public:
    int perfectMenu(vector<int>& materials, vector<vector<int>>& cookbooks, vector<vector<int>>& attribute, int limit) {
        int n = cookbooks.size();
        int maxDelicious = -1;

        for (int mask = 0; mask < (1 << n); ++mask) {
            vector<int> used(5, 0);
            int totalDelicious = 0;
            int totalFull = 0;

            for (int i = 0; i < n; ++i) {
                if (mask & (1 << i)) {
                    for (int j = 0; j < 5; ++j) {
                        used[j] += cookbooks[i][j];
                    }
                    totalDelicious += attribute[i][0];
                    totalFull += attribute[i][1];
                }
            }

            bool valid = true;
            for (int j = 0; j < 5; ++j) {
                if (used[j] > materials[j]) {
                    valid = false;
                    break;
                }
            }

            if (valid && totalFull >= limit) {
                if (totalDelicious > maxDelicious) {
                    maxDelicious = totalDelicious;
                }
            }
        }

        return maxDelicious;
    }
};