#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string largestNumber(vector<int>& nums) {
        vector<int> even;
        vector<int> odd;
        for (int num : nums) {
            if (num % 2 == 0) {
                even.push_back(num);
            } else {
                odd.push_back(num);
            }
        }
        sort(even.begin(), even.end(), greater<int>());
        sort(odd.begin(), odd.end(), greater<int>());
        string result;
        int e = 0, o = 0;
        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] % 2 == 0) {
                result += to_string(even[e++]);
            } else {
                result += to_string(odd[o++]);
            }
        }
        return result;
    }
};