#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int inventoryManagement(vector<int>& stock, int cnt) {
        sort(stock.begin(), stock.end());
        return stock[cnt - 1];
    }
};