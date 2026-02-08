#include <string>
#include <unordered_set>

class Solution {
public:
    int numJewelsInStones(std::string jewels, std::string stones) {
        std::unordered_set<char> jewelSet;
        for (char c : jewels) {
            jewelSet.insert(c);
        }

        int count = 0;
        for (char c : stones) {
            if (jewelSet.count(c)) {
                count++;
            }
        }

        return count;
    }
};