#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<vector<int>> palindromePairs(vector<string>& words) {
        unordered_map<string, int> word_map;
        for (int i = 0; i < words.size(); ++i) {
            string reversed_word = words[i];
            reverse(reversed_word.begin(), reversed_word.end());
            word_map[reversed_word] = i;
        }

        vector<vector<int>> result;
        for (int i = 0; i < words.size(); ++i) {
            for (int j = 0; j <= words[i].size(); ++j) {
                string prefix = words[i].substr(0, j);
                string suffix = words[i].substr(j);

                if (isPalindrome(prefix)) {
                    string reversed_suffix = suffix;
                    reverse(reversed_suffix.begin(), reversed_suffix.end());
                    if (word_map.count(reversed_suffix) && word_map[reversed_suffix] != i) {
                        result.push_back({word_map[reversed_suffix], i});
                    }
                }

                if (isPalindrome(suffix) && suffix.length() != 0) {
                    string reversed_prefix = prefix;
                    reverse(reversed_prefix.begin(), reversed_prefix.end());
                    if (word_map.count(reversed_prefix) && word_map[reversed_prefix] != i) {
                        result.push_back({i, word_map[reversed_prefix]});
                    }
                }
            }
        }

        return result;
    }

private:
    bool isPalindrome(const string& s) {
        int left = 0;
        int right = s.size() - 1;
        while (left < right) {
            if (s[left] != s[right]) {
                return false;
            }
            ++left;
            --right;
        }
        return true;
    }
};