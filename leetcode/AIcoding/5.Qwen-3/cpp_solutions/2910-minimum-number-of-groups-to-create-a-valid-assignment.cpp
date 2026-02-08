#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>
#include <map>

using namespace std;

class Solution {
public:
    int minGroups(vector<int>& nums) {
        map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }

        vector<int> counts;
        for (auto& [num, count] : freq) {
            counts.push_back(count);
        }

        sort(counts.begin(), counts.end());

        int n = counts.size();
        int total = accumulate(counts.begin(), counts.end(), 0);

        int left = 1, right = total;
        int result = total;

        while (left <= right) {
            int mid = (left + right) / 2;
            int groups = 0;
            bool valid = true;

            for (int count : counts) {
                if (count % mid == 0) {
                    groups += count / mid;
                } else {
                    groups += count / mid + 1;
                }
            }

            if (groups <= total / mid) {
                result = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return result;
    }
};