#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> singleNumber(vector<int>& nums) {
        unordered_set<int> seen;
        vector<int> result;

        for (int num : nums) {
            if (seen.find(num) != seen.end()) {
                seen.erase(num);
            } else {
                seen.insert(num);
            }
        }

        for (int num : seen) {
            result.push_back(num);
        }

        return result;
    }
};