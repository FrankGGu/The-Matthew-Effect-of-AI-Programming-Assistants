#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxCost(string s, vector<int>& cost, string chars, vector<int>& cost_chars) {
        vector<int> char_costs(26, 0);
        for (int i = 0; i < 26; ++i) {
            char_costs[i] = i + 1;
        }
        for (int i = 0; i < chars.size(); ++i) {
            char_costs[chars[i] - 'a'] = cost_chars[i];
        }

        int max_so_far = 0;
        int current_max = 0;

        for (int i = 0; i < s.size(); ++i) {
            current_max += char_costs[s[i] - 'a'];
            if (current_max < 0) {
                current_max = 0;
            }
            max_so_far = max(max_so_far, current_max);
        }

        return max_so_far;
    }
};