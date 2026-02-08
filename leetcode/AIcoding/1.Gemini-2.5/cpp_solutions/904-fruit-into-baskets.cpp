#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int totalFruit(std::vector<int>& fruits) {
        int max_fruits = 0;
        int left = 0;
        std::unordered_map<int, int> fruit_counts;

        for (int right = 0; right < fruits.size(); ++right) {
            fruit_counts[fruits[right]]++;

            while (fruit_counts.size() > 2) {
                fruit_counts[fruits[left]]--;
                if (fruit_counts[fruits[left]] == 0) {
                    fruit_counts.erase(fruits[left]);
                }
                left++;
            }
            max_fruits = std::max(max_fruits, right - left + 1);
        }
        return max_fruits;
    }
};