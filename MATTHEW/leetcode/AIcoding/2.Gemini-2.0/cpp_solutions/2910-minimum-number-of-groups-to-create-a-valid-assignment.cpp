#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    int minGroupsForValidAssignment(vector<int>& nums) {
        map<int, int> counts;
        for (int num : nums) {
            counts[num]++;
        }

        vector<int> freq;
        for (auto const& [key, val] : counts) {
            freq.push_back(val);
        }

        int minFreq = *min_element(freq.begin(), freq.end());

        for (int x = minFreq; x >= 1; --x) {
            int groups = 0;
            bool possible = true;
            for (int f : freq) {
                int numGroups = 0;
                if (f < x) {
                    possible = false;
                    break;
                }

                if (f % (x + 1) == 0) {
                    numGroups = f / (x + 1);
                } else {
                    int k = f / (x + 1);
                    int rem = f % (x + 1);
                    if ((x+1) - rem <= k) {
                       numGroups = k + 1;
                    } else {
                        possible = false;
                        break;
                    }
                }
                groups += numGroups;
            }

            if (possible) {
                return groups;
            }
        }
        return nums.size();
    }
};