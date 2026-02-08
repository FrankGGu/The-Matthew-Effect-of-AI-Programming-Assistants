#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    bool canMakeEqual(vector<string>& s1, vector<string>& s2) {
        int cnt[26] = {0};
        for (const string& str : s1) {
            for (char c : str) {
                cnt[c - 'a']++;
            }
        }
        for (const string& str : s2) {
            for (char c : str) {
                cnt[c - 'a']--;
            }
        }
        for (int i = 0; i < 26; ++i) {
            if (cnt[i] != 0) return false;
        }
        return true;
    }
};