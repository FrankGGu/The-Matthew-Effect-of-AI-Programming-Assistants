#include <vector>

class Solution {
public:
    std::vector<int> grayCode(int n) {
        std::vector<int> result;
        int num_elements = 1 << n;

        for (int i = 0; i < num_elements; ++i) {
            result.push_back(i ^ (i >> 1));
        }

        return result;
    }
};