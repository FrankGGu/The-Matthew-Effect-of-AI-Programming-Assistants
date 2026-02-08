#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    int majorityElement(vector<int>& nums) {
        map<int, int> count;
        for (int num : nums) {
            count[num]++;
            if (count[num] > nums.size() / 2) {
                return num;
            }
        }
        return -1;
    }
};