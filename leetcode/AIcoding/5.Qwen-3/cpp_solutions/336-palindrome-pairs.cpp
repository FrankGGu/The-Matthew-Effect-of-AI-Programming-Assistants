#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<vector<int>> palindromePairs(vector<string>& words) {
        vector<vector<int>> result;
        int n = words.size();
        if (n < 2) return result;

        unordered_map<string, int> wordMap;
        for (int i = 0; i < n; ++i) {
            wordMap[words[i]] = i;
        }

        for (int i = 0; i < n; ++i) {
            string word = words[i];
            for (int j = 0; j <= word.size(); ++j) {
                string left = word.substr(0, j);
                string right = word.substr(j);
                if (left.empty() || right.empty()) continue;

                reverse(left.begin(), left.end());
                if (wordMap.find(left) != wordMap.end() && wordMap[left] != i) {
                    if (isPalindrome(right)) {
                        result.push_back({i, wordMap[left]});
                    }
                }

                reverse(right.begin(), right.end());
                if (wordMap.find(right) != wordMap.end() && wordMap[right] != i) {
                    if (isPalindrome(left)) {
                        result.push_back({wordMap[right], i});
                    }
                }
            }
        }

        return result;
    }

private:
    bool isPalindrome(const string& s) {
        int left = 0, right = s.size() - 1;
        while (left < right) {
            if (s[left++] != s[right--]) return false;
        }
        return true;
    }
};