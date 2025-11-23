#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int numberOfWeakCharacters(vector<int>& nums) {
        sort(nums.begin(), nums.end(), [](const vector<int>& a, const vector<int>& b) {
            if (a[0] == b[0]) {
                return a[1] > b[1];
            }
            return a[0] < b[0];
        });

        int count = 0;
        int maxDef = 0;

        for (const auto& p : nums) {
            if (p[1] < maxDef) {
                count++;
            } else {
                maxDef = p[1];
            }
        }

        return count;
    }
};