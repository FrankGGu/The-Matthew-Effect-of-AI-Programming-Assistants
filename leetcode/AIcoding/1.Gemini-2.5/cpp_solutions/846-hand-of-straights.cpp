#include <vector>
#include <map>
#include <numeric>

class Solution {
public:
    bool isNStraightHand(std::vector<int>& hand, int groupSize) {
        int n = hand.size();

        if (n % groupSize != 0) {
            return false;
        }

        std::map<int, int> counts;
        for (int card : hand) {
            counts[card]++;
        }

        for (auto it = counts.begin(); it != counts.end(); ++it) {
            int current_card = it->first;
            int freq = it->second;

            if (freq == 0) {
                continue;
            }

            for (int i = 0; i < groupSize; ++i) {
                int needed_card = current_card + i;

                auto it_needed = counts.find(needed_card);
                if (it_needed == counts.end() || it_needed->second < freq) {
                    return false;
                }

                it_needed->second -= freq;
            }
        }

        return true;
    }
};