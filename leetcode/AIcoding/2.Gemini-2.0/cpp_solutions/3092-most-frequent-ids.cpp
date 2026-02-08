#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int mostFrequentIDs(vector<int>& ids) {
        unordered_map<int, int> counts;
        for (int id : ids) {
            counts[id]++;
        }

        int mostFrequent = ids[0];
        int maxCount = counts[ids[0]];

        for (auto const& [id, count] : counts) {
            if (count > maxCount) {
                maxCount = count;
                mostFrequent = id;
            }
        }

        return mostFrequent;
    }
};