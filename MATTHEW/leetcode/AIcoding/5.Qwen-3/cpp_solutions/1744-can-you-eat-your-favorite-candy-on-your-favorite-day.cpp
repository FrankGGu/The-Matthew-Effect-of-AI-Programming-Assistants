#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<bool> canEat(vector<int>& candiesCount, vector<vector<int>>& queries) {
        int n = candiesCount.size();
        vector<bool> result(queries.size());
        vector<long long> prefix(n + 1, 0);

        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + candiesCount[i];
        }

        for (int i = 0; i < queries.size(); ++i) {
            int favoriteCandy = queries[i][0];
            int startDay = queries[i][1];
            int endDay = queries[i][2];

            long long minEaten = startDay;
            long long maxEaten = endDay;

            long long minPossible = prefix[favoriteCandy];
            long long maxPossible = prefix[favoriteCandy + 1];

            if (maxEaten < 1 || minEaten >= maxPossible) {
                result[i] = false;
            } else if (minEaten > maxPossible || maxEaten < minPossible) {
                result[i] = false;
            } else {
                result[i] = true;
            }
        }

        return result;
    }
};