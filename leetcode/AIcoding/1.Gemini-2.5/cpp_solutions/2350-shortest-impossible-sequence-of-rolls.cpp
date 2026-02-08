#include <vector>
#include <unordered_set>

class Solution {
public:
    int shortestSequence(std::vector<int>& rolls, int k) {
        int ans = 1;
        std::unordered_set<int> seen;
        for (int roll : rolls) {
            seen.insert(roll);
            if (seen.size() == k) {
                ans++;
                seen.clear();
            }
        }
        return ans;
    }
};