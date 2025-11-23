#include <vector>
#include <string>

class Solution {
public:
    int countPrefixSuffixPairs(std::vector<std::string>& words) {
        int n = words.size();
        int count = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                const std::string& s1 = words[i];
                const std::string& s2 = words[j];

                if (s2.length() < s1.length()) {
                    continue;
                }

                bool isPrefix = (s2.compare(0, s1.length(), s1) == 0);

                bool isSuffix = (s2.compare(s2.length() - s1.length(), s1.length(), s1) == 0);

                if (isPrefix && isSuffix) {
                    count++;
                }
            }
        }
        return count;
    }
};