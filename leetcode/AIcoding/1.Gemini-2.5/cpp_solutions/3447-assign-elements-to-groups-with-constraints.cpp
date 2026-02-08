#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minGroupsForValidAssignment(vector<int>& nums) {
        unordered_map<int, int> counts;
        for (int num : nums) {
            counts[num]++;
        }

        vector<int> freq;
        for (auto const& [key, val] : counts) {
            freq.push_back(val);
        }

        sort(freq.begin(), freq.end());

        int n = freq.size();
        int max_freq = freq.back();

        for (int k = max_freq; k >= 1; --k) {
            bool possible = true;
            int groups = 0;
            for (int f : freq) {
                int num_groups = 0;
                if (f < k) {
                    if (f % (k + 1) != 0) {
                        possible = false;
                        break;
                    }
                    num_groups = f / (k + 1);
                } else {
                    num_groups = f / (k + 1);
                    int remaining = f % (k + 1);
                    if (remaining > 0) {
                        num_groups++;
                    }
                }

                int x = f / k;
                int y = f % k;
                if(y != 0){
                    bool found = false;
                    for(int j = k-1; j >= 1; --j){
                        if((f-j) >= 0 && (f-j) % (j+1) == 0){
                            found = true;
                            break;
                        }
                    }

                }

                groups += (f + k) / (k + 1);
            }
            if (possible) {
                return groups;
            }
        }

        return n;
    }
};