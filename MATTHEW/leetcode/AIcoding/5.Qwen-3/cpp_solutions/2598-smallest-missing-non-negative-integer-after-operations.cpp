#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int findSmallestInteger(int n, vector<int>& nums) {
        unordered_set<int> s;
        for (int num : nums) {
            s.insert(num);
        }
        for (int i = 0; i < n; ++i) {
            if (s.find(i) == s.end()) {
                return i;
            }
        }
        return n;
    }
};