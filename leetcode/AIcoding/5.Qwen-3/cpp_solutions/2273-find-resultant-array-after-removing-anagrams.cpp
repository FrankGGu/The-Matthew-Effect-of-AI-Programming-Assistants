#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> removeAnagrams(vector<string>& nums) {
        vector<string> result;
        for (const string& num : nums) {
            if (result.empty() || !isAnagram(result.back(), num)) {
                result.push_back(num);
            }
        }
        return result;
    }

private:
    bool isAnagram(const string& a, const string& b) {
        if (a.size() != b.size()) return false;
        vector<int> count(26, 0);
        for (char c : a) count[c - 'a']++;
        for (char c : b) count[c - 'a']--;
        for (int i : count) {
            if (i != 0) return false;
        }
        return true;
    }
};