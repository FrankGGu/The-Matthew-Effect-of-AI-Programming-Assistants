#include <iostream>
#include <vector>
#include <algorithm>
#include <random>

using namespace std;

class Solution {
private:
    vector<int> original;
    vector<int> shuffled;
    int n;
    default_random_engine gen;

public:
    Solution(vector<int>& nums) : original(nums), n(nums.size()), shuffled(nums), gen(random_device{}()) {}

    vector<int> reset() {
        shuffled = original;
        return shuffled;
    }

    vector<int> shuffle() {
        if (n <= 1) return shuffled;
        for (int i = n - 1; i > 0; --i) {
            uniform_int_distribution<int> dist(0, i);
            swap(shuffled[i], shuffled[dist(gen)]);
        }
        return shuffled;
    }
};