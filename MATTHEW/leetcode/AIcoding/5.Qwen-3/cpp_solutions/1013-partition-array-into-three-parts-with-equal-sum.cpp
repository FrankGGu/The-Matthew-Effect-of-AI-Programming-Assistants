#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    bool canThreePartsInArray(vector<int>& arr) {
        int total = 0;
        for (int num : arr) {
            total += num;
        }
        if (total % 3 != 0) {
            return false;
        }
        int target = total / 3;
        int count = 0;
        int currentSum = 0;
        for (int num : arr) {
            currentSum += num;
            if (currentSum == target) {
                count++;
                currentSum = 0;
            }
        }
        return count >= 3;
    }
};