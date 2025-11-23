#include <vector>
#include <string>
#include <algorithm> // Not strictly needed for this solution, but good practice for vector operations

class Solution {
public:
    std::vector<int> lastVisitedIntegers(std::vector<std::string>& words) {
        std::vector<int> visited_nums;
        std::vector<int> result;
        int prev_count = 0;

        for (const std::string& word : words) {
            if (word == "prev") {
                prev_count++;
                if (prev_count <= visited_nums.size()) {
                    result.push_back(visited_nums[visited_nums.size() - prev_count]);
                } else {
                    result.push_back(-1);
                }
            } else {
                visited_nums.push_back(std::stoi(word));
                prev_count = 0;
            }
        }
        return result;
    }
};