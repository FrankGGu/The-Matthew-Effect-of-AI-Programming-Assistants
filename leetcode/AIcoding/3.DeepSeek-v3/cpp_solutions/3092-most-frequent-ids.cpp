#include <vector>
#include <unordered_map>
#include <set>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<long long> mostFrequentIDs(vector<int>& nums, vector<int>& freq) {
        unordered_map<int, long long> count;
        multiset<long long> freqSet;
        vector<long long> result;

        for (int i = 0; i < nums.size(); ++i) {
            int id = nums[i];
            long long currentCount = count[id];
            if (currentCount > 0) {
                auto it = freqSet.find(currentCount);
                if (it != freqSet.end()) {
                    freqSet.erase(it);
                }
            }
            count[id] += freq[i];
            if (count[id] > 0) {
                freqSet.insert(count[id]);
            }
            if (!freqSet.empty()) {
                result.push_back(*freqSet.rbegin());
            } else {
                result.push_back(0);
            }
        }

        return result;
    }
};