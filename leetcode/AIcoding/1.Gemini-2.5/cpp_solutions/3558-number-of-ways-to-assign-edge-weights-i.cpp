#include <vector>

class Solution {
public:
    int numberOfWays(int n, std::vector<std::vector<int>>& edges, std::vector<int>& special) {
        int k = special.size();
        int power = n - k;
        return 1 << power;
    }
};