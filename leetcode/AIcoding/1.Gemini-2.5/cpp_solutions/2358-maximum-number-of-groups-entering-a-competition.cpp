#include <vector>
#include <cmath>

class Solution {
public:
    int maximumGroups(std::vector<int>& grades) {
        int n = grades.size();
        return static_cast<int>(floor((-1 + sqrt(1 + 8.0 * n)) / 2.0));
    }
};