#include <vector>
#include <map>
#include <algorithm>

class Solution {
public:
    bool isNStraightHand(std::vector<int>& hand, int groupSize) {
        if (hand.size() % groupSize != 0) {
            return false;
        }

        std::map<int, int> countMap;
        for (int num : hand) {
            countMap[num]++;
        }

        while (!countMap.empty()) {
            int current = countMap.begin()->first;
            for (int i = 0; i < groupSize; ++i) {
                if (countMap.find(current + i) == countMap.end()) {
                    return false;
                }
                if (--countMap[current + i] == 0) {
                    countMap.erase(current + i);
                }
            }
        }

        return true;
    }
};