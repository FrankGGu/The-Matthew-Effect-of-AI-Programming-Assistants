#include <vector>
#include <algorithm>

class Solution {
public:
    int numberOfWeakCharacters(std::vector<std::vector<int>>& properties) {
        std::sort(properties.begin(), properties.end(), [](const std::vector<int>& a, const std::vector<int>& b) {
            if (a[0] != b[0]) {
                return a[0] > b[0];
            }
            return a[1] < b[1];
        });

        int weak_characters_count = 0;
        int max_defense_so_far = 0;

        for (const auto& p : properties) {
            int current_defense = p[1];

            if (current_defense < max_defense_so_far) {
                weak_characters_count++;
            }

            max_defense_so_far = std::max(max_defense_so_far, current_defense);
        }

        return weak_characters_count;
    }
};