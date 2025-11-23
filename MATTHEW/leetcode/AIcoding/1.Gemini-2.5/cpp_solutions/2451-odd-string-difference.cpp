#include <vector>
#include <string>
#include <numeric>

class Solution {
public:
    std::string oddString(std::vector<std::string>& words) {
        auto get_diff = [](const std::string& s) {
            std::vector<int> diff;
            for (size_t i = 0; i < s.length() - 1; ++i) {
                diff.push_back(s[i + 1] - s[i]);
            }
            return diff;
        };

        std::vector<int> diff0 = get_diff(words[0]);
        std::vector<int> diff1 = get_diff(words[1]);

        if (diff0 == diff1) {
            for (size_t i = 2; i < words.size(); ++i) {
                if (get_diff(words[i]) != diff0) {
                    return words[i];
                }
            }
        } else {
            std::vector<int> diff2 = get_diff(words[2]);
            if (diff2 == diff0) {
                return words[1];
            } else {
                return words[0];
            }
        }

        return "";
    }
};