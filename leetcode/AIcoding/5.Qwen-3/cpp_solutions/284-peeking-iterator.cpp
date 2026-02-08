#include <iostream>
#include <vector>
#include <iterator>

using namespace std;

class PeekingIterator {
private:
    vector<int> nums;
    int index;

public:
    PeekingIterator(const vector<int>& nums) : nums(nums), index(0) {}

    int peek() {
        return nums[index];
    }

    int next() {
        return nums[index++];
    }

    bool hasNext() {
        return index < nums.size();
    }
};

class Solution {
public:
    int peekingIterator(const vector<int>& nums) {
        PeekingIterator iter(nums);
        int result = 0;
        while (iter.hasNext()) {
            result = iter.peek();
            iter.next();
        }
        return result;
    }
};