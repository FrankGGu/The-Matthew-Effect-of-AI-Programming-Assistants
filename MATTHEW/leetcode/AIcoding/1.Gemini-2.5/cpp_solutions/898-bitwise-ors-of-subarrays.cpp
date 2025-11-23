#include <vector>
#include <unordered_set>

class Solution {
public:
    int subarrayBitwiseORs(std::vector<int>& arr) {
        std::unordered_set<int> result;
        std::unordered_set<int> current;

        for (int x : arr) {
            std::unordered_set<int> next;
            next.insert(x);
            for (int prev_or : current) {
                next.insert(prev_or | x);
            }
            current = next;
            result.insert(current.begin(), current.end());
        }

        return result.size();
    }
};