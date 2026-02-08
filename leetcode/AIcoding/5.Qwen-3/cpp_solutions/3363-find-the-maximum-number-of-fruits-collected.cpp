#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxTotalFruits(vector<vector<int>>& position, vector<int>& amount) {
        int n = position.size();
        vector<pair<int, int>> fruits;
        for (int i = 0; i < n; ++i) {
            fruits.push_back({position[i][0], amount[i]});
        }
        sort(fruits.begin(), fruits.end());

        unordered_map<int, int> posToIndex;
        for (int i = 0; i < n; ++i) {
            posToIndex[fruits[i].first] = i;
        }

        vector<int> prefix(n, 0);
        prefix[0] = fruits[0].second;
        for (int i = 1; i < n; ++i) {
            prefix[i] = prefix[i - 1] + fruits[i].second;
        }

        int result = 0;
        for (int i = 0; i < n; ++i) {
            int left = i;
            int right = n - 1;
            int best = i;
            while (left <= right) {
                int mid = (left + right) / 2;
                if (fruits[mid].first - fruits[i].first <= 500) {
                    best = mid;
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
            int total = prefix[best] - (i > 0 ? prefix[i - 1] : 0);
            result = max(result, total);
        }

        return result;
    }
};