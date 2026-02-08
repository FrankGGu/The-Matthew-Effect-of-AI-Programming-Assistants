#include <string>
#include <algorithm>
#include <limits>

class Solution {
public:
    int nextGreaterElement(int n) {
        std::string s = std::to_string(n);

        if (!std::next_permutation(s.begin(), s.end())) {
            return -1;
        }

        long long res = std::stoll(s);

        if (res > std::numeric_limits<int>::max()) {
            return -1;
        }

        return static_cast<int>(res);
    }
};