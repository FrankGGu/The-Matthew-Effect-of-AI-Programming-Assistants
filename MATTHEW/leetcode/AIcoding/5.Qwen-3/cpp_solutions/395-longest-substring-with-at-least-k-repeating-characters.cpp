#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestSubstring(string s, int k) {
        return helper(s, 0, s.length() - 1, k);
    }

private:
    int helper(string& s, int left, int right, int k) {
        if (right - left + 1 < k) return 0;
        unordered_map<char, int> count;
        for (int i = left; i <= right; ++i) {
            count[s[i]]++;
        }
        for (int i = left; i <= right; ++i) {
            if (count[s[i]] < k) {
                int leftResult = helper(s, left, i - 1, k);
                int rightResult = helper(s, i + 1, right, k);
                return max(leftResult, rightResult);
            }
        }
        return right - left + 1;
    }
};