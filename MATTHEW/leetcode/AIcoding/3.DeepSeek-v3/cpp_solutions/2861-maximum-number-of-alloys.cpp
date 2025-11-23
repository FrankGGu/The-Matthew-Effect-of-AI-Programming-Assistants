class Solution {
public:
    int maxNumberOfAlloys(int n, int k, int budget, vector<vector<int>>& composition, vector<int>& stock, vector<int>& cost) {
        int left = 0, right = 2e8, answer = 0;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            bool possible = false;
            for (int i = 0; i < k; ++i) {
                long long total = 0;
                for (int j = 0; j < n; ++j) {
                    long long needed = (long long)composition[i][j] * mid - stock[j];
                    if (needed > 0) {
                        total += needed * cost[j];
                    }
                    if (total > budget) {
                        break;
                    }
                }
                if (total <= budget) {
                    possible = true;
                    break;
                }
            }
            if (possible) {
                answer = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return answer;
    }
};