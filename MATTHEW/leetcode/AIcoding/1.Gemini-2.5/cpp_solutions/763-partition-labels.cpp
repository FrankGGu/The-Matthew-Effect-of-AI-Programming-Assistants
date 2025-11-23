#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> partitionLabels(std::string s) {
        std::vector<int> last_occurrence(26, 0);
        for (int i = 0; i < s.length(); ++i) {
            last_occurrence[s[i] - 'a'] = i;
        }

        std::vector<int> result;
        int start = 0;
        int end = 0;

        for (int i = 0; i < s.length(); ++i) {
            end = std::max(end, last_occurrence[s[i] - 'a']);

            if (i == end) {
                result.push_back(i - start + 1);
                start = i + 1;
            }
        }

        return result;
    }
};