#include <vector>

class Solution {
public:
    std::vector<int> colorTheArray(int n, std::vector<std::vector<int>>& queries) {
        std::vector<int> colors(n, 0);
        std::vector<int> ans;
        int count = 0;

        for (const auto& query : queries) {
            int index = query[0];
            int new_color = query[1];

            if (colors[index] == new_color) {
                ans.push_back(count);
                continue;
            }

            int prev_color = colors[index];

            if (prev_color != 0) {
                if (index > 0 && colors[index - 1] == prev_color) {
                    count--;
                }
                if (index < n - 1 && colors[index + 1] == prev_color) {
                    count--;
                }
            }

            colors[index] = new_color;

            if (index > 0 && colors[index - 1] == new_color) {
                count++;
            }
            if (index < n - 1 && colors[index + 1] == new_color) {
                count++;
            }

            ans.push_back(count);
        }
        return ans;
    }
};