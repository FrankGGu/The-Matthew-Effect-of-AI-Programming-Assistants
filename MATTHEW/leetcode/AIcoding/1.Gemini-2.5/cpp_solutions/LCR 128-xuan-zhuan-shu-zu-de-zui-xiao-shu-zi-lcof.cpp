#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int inventoryManagement(std::vector<int>& stock, int k) {
        std::sort(stock.begin(), stock.end());
        long long sum = 0;
        for (int i = k; i < stock.size(); ++i) {
            sum += stock[i];
        }
        return static_cast<int>(sum);
    }
};