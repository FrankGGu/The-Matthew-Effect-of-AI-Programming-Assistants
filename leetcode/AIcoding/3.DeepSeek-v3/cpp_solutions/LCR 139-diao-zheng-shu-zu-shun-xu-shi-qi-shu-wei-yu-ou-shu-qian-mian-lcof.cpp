#include <vector>
#include <unordered_set>

class Solution {
public:
    bool trainingPlan(std::vector<int>& actions) {
        std::unordered_set<int> seen;
        for (int num : actions) {
            if (seen.find(num) != seen.end()) {
                return false;
            }
            seen.insert(num);
        }
        return true;
    }
};