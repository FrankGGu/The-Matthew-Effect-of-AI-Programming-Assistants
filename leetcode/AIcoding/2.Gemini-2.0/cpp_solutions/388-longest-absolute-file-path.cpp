#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int lengthLongestPath(string input) {
        vector<int> level_len(1, 0);
        int max_len = 0;
        size_t pos = 0;
        while (pos < input.size()) {
            int level = 0;
            while (pos < input.size() && input[pos] == '\t') {
                level++;
                pos++;
            }
            int len = 0;
            bool is_file = false;
            while (pos < input.size() && input[pos] != '\n') {
                if (input[pos] == '.') {
                    is_file = true;
                }
                len++;
                pos++;
            }
            if (pos < input.size()) {
                pos++;
            }
            if (level + 1 > level_len.size()) {
                level_len.push_back(0);
            }
            level_len[level + 1] = level_len[level] + len + 1;
            if (is_file) {
                max_len = max(max_len, level_len[level + 1] - 1);
            }
        }
        return max_len;
    }
};