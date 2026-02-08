#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int maxUniqueSplit(string s) {
        int result = 0;
        unordered_set<string> uniqueSubstrings;
        backtrack(s, 0, uniqueSubstrings, result);
        return result;
    }

private:
    void backtrack(const string& s, int start, unordered_set<string>& uniqueSubstrings, int& result) {
        if (start == s.length()) {
            result = max(result, static_cast<int>(uniqueSubstrings.size()));
            return;
        }
        for (int end = start + 1; end <= s.length(); ++end) {
            string substring = s.substr(start, end - start);
            if (uniqueSubstrings.find(substring) == uniqueSubstrings.end()) {
                uniqueSubstrings.insert(substring);
                backtrack(s, end, uniqueSubstrings, result);
                uniqueSubstrings.erase(substring);
            }
        }
    }
};