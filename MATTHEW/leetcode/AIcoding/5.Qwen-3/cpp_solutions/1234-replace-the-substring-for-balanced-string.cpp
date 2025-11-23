#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int balancedString(string s, int k) {
        int n = s.size();
        int res = n;
        unordered_map<char, int> count;
        for (char c : s) count[c]++;

        int left = 0;
        for (int right = 0; right < n; right++) {
            count[s[right]]--;
            while (count['a'] <= n / 4 && count['b'] <= n / 4 && count['c'] <= n / 4 && count['d'] <= n / 4) {
                res = min(res, right - left + 1);
                count[s[left]]++;
                left++;
            }
        }
        return res;
    }
};