#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    int maxTotalFruits(vector<vector<int>>& position, vector<int>& amount, int k) {
        int n = position.size();
        vector<pair<int, int>> posAmount(n);
        for (int i = 0; i < n; ++i) {
            posAmount[i] = {position[i][0], amount[i]};
        }

        sort(posAmount.begin(), posAmount.end());

        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + posAmount[i].second;
        }

        int res = 0;
        for (int i = 0; i < n; ++i) {
            int left = i;
            int right = n - 1;
            while (left <= right) {
                int mid = (left + right) / 2;
                int dist = posAmount[mid].first - posAmount[i].first;
                if (dist <= k) {
                    res = max(res, prefix[mid + 1] - prefix[i]);
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
        }

        for (int i = 0; i < n; ++i) {
            int left = 0;
            int right = i;
            while (left <= right) {
                int mid = (left + right) / 2;
                int dist = posAmount[i].first - posAmount[mid].first;
                if (dist <= k) {
                    res = max(res, prefix[i + 1] - prefix[mid]);
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            }
        }

        return res;
    }
};