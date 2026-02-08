#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool check(vector<int>& inventory, int m) {
        sort(inventory.begin(), inventory.end(), greater<int>());
        long long sum = 0;
        for (int i = 0; i < m && i < inventory.size(); ++i) {
            sum += inventory[i];
        }
        return sum >= m;
    }
};