#include <vector>
#include <string>
#include <algorithm>
#include <cmath>

class Solution {
public:
    std::vector<int> beautifulIndices(std::string s, std::string a, std::string b, int k) {
        std::vector<int> indices_a;
        std::string::size_type pos = 0;
        while ((pos = s.find(a, pos)) != std::string::npos) {
            indices_a.push_back(static_cast<int>(pos));
            pos++;
        }

        std::vector<int> indices_b;
        pos = 0;
        while ((pos = s.find(b, pos)) != std::string::npos) {
            indices_b.push_back(static_cast<int>(pos));
            pos++;
        }

        if (indices_a.empty() || indices_b.empty()) {
            return {};
        }

        std::vector<int> result;
        size_t ptr_b = 0;
        for (int i : indices_a) {
            while (ptr_b < indices_b.size() && indices_b[ptr_b] < i - k) {
                ptr_b++;
            }
            if (ptr_b < indices_b.size() && indices_b[ptr_b] <= i + k) {
                result.push_back(i);
            }
        }

        return result;
    }
};