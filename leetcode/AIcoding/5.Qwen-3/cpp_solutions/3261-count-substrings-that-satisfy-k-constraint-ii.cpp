#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countKConstraintSubstrings(string s, int k) {
        int n = s.length();
        int result = 0;
        for (int i = 0; i < n; ++i) {
            unordered_map<char, int> count;
            for (int j = i; j < n; ++j) {
                count[s[j]]++;
                if (count['0'] <= k && count['1'] <= k) {
                    result++;
                }
            }
        }
        return result;
    }
};