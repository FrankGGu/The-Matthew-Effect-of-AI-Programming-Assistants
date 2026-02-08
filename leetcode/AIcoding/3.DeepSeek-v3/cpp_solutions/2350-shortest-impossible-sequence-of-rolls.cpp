#include <vector>
#include <unordered_set>

class Solution {
public:
    int shortestSequence(std::vector<int>& rolls, int k) {
        std::unordered_set<int> seen;
        int res = 1;
        for (int num : rolls) {
            seen.insert(num);
            if (seen.size() == k) {
                res++;
                seen.clear();
            }
        }
        return res;
    }
};