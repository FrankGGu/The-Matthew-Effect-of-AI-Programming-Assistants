#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> sortItems(vector<int>& n, vector<vector<int>>& items, vector<vector<int>>& queries) {
        int m = items.size();
        int k = queries.size();
        vector<vector<int>> result(k);

        for (int i = 0; i < k; ++i) {
            int price = queries[i][0];
            int beauty = queries[i][1];
            vector<int> temp;
            for (int j = 0; j < m; ++j) {
                if (items[j][0] <= price && items[j][1] >= beauty) {
                    temp.push_back(items[j][2]);
                }
            }
            sort(temp.begin(), temp.end());
            result[i] = {price, beauty, temp.empty() ? -1 : temp[0]};
        }

        return result;
    }
};