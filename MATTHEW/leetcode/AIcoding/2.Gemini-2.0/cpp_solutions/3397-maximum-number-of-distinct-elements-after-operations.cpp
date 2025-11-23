#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    int maxDistinctElements(vector<int>& nums, int k) {
        map<int, int> counts;
        for (int num : nums) {
            counts[num]++;
        }

        vector<int> freq;
        for (auto const& [key, val] : counts) {
            freq.push_back(val);
        }

        sort(freq.begin(), freq.end());

        int removed = 0;
        int distinct = counts.size();

        for (int i = 0; i < freq.size(); ++i) {
            if (freq[i] - 1 <= k) {
                k -= (freq[i] - 1);
                removed++;
            } else {
                break;
            }
        }

        distinct -= removed;

        distinct += min((int)counts.size() - removed, k);

        return distinct;
    }
};