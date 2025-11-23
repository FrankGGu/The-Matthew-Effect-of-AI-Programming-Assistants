#include <iostream>
#include <vector>
#include <map>
#include <unordered_map>

using namespace std;

class Solution {
public:
    Solution() {}

    void change(int index, int number) {
        if (index >= 0 && index < nums.size()) {
            nums[index] = number;
        }
    }

    int find(int index) {
        if (index >= 0 && index < nums.size()) {
            return nums[index];
        }
        return -1;
    }

    int[] getNumbers() {
        int size = nums.size();
        int* result = new int[size];
        for (int i = 0; i < size; ++i) {
            result[i] = nums[i];
        }
        return result;
    }

private:
    vector<int> nums;
};