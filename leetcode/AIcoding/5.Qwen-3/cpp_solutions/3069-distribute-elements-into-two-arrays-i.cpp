#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> distributeElementsIntoTwoArrays(vector<int>& nums) {
        vector<int> arr1;
        vector<int> arr2;
        unordered_map<int, int> count;

        for (int num : nums) {
            if (count[num] % 2 == 0) {
                arr1.push_back(num);
            } else {
                arr2.push_back(num);
            }
            count[num]++;
        }

        return {arr1.size(), arr2.size()};
    }
};