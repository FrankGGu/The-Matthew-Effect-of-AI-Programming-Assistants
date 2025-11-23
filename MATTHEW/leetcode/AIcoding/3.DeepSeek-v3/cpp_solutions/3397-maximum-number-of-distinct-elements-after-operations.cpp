#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumDistinctElements(vector<int>& nums, int k) {
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }

        vector<int> counts;
        for (auto& pair : freq) {
            counts.push_back(pair.second);
        }

        sort(counts.begin(), counts.end());

        int distinct = 0;
        for (int cnt : counts) {
            if (cnt == 1) {
                distinct++;
            } else {
                int needed = cnt - 1;
                if (k >= needed) {
                    k -= needed;
                    distinct++;
                } else {
                    int remaining = cnt - k;
                    if (remaining == 1) {
                        distinct++;
                    }
                    k = 0;
                }
            }
            if (k == 0) {
                break;
            }
        }

        if (k > 0) {
            distinct -= k;
        }

        return max(distinct, 0);
    }
};