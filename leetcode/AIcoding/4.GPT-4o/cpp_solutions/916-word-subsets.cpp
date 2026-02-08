#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    std::vector<std::string> wordSubsets(std::vector<std::string>& A, std::vector<std::string>& B) {
        std::vector<int> maxCount(26, 0);

        for (const auto& b : B) {
            std::vector<int> count(26, 0);
            for (char c : b) {
                count[c - 'a']++;
            }
            for (int i = 0; i < 26; ++i) {
                maxCount[i] = std::max(maxCount[i], count[i]);
            }
        }

        std::vector<std::string> result;
        for (const auto& a : A) {
            std::vector<int> count(26, 0);
            for (char c : a) {
                count[c - 'a']++;
            }
            bool isSubset = true;
            for (int i = 0; i < 26; ++i) {
                if (count[i] < maxCount[i]) {
                    isSubset = false;
                    break;
                }
            }
            if (isSubset) {
                result.push_back(a);
            }
        }

        return result;
    }
};