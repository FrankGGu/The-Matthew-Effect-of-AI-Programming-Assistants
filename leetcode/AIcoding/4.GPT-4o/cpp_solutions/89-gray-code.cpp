#include <vector>

class Solution {
public:
    std::vector<int> grayCode(int n) {
        std::vector<int> result;
        int total = 1 << n;
        for (int i = 0; i < total; ++i) {
            result.push_back(i ^ (i >> 1));
        }
        return result;
    }
};