#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int inventoryManagement(vector<int>& stock, int cnt) {
        if (stock.empty() || cnt == 0) return 0;
        vector<int> res;
        for (int i = 0; i < cnt; ++i) {
            res.push_back(stock[i]);
        }
        return res.back();
    }
};