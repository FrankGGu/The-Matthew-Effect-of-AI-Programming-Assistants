#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int eatPizzas(vector<int>& pizzas, int k) {
        int n = pizzas.size();
        sort(pizzas.begin(), pizzas.end(), greater<int>());
        int ans = 0;
        for (int i = 0; i < min(k, n); ++i) {
            ans += pizzas[i];
        }
        return ans;
    }
};