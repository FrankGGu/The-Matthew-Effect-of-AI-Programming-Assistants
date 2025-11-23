#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    int maxCoins(vector<int>& bags, int k) {
        sort(bags.begin(), bags.end(), greater<int>());
        int maxCoins = 0;
        for (int i = 0; i < k && i < bags.size(); ++i) {
            maxCoins += bags[i];
        }
        return maxCoins;
    }
};