#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    int mostFrequentEven(vector<int>& nums) {
        map<int, int> counts;
        for (int num : nums) {
            if (num % 2 == 0) {
                counts[num]++;
            }
        }

        int mostFrequent = -1;
        int maxCount = 0;

        for (auto const& [num, count] : counts) {
            if (count > maxCount) {
                maxCount = count;
                mostFrequent = num;
            } else if (count == maxCount && num < mostFrequent) {
                mostFrequent = num;
            }
        }

        return mostFrequent;
    }
};