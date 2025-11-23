#include <vector>
#include <unordered_set>

class Solution {
public:
    bool canTransform(std::vector<int>& arr) {
        std::unordered_set<int> uniqueElements(arr.begin(), arr.end());
        for (int num : uniqueElements) {
            if (num != 0 && num != 1) return false;
        }
        return true;
    }
};