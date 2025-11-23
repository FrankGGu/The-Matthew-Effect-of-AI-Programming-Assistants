#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>
#include <set>

class Solution {
private:
    bool isPalindrome(const std::string& s) {
        int left = 0;
        int right = s.length() - 1;
        while (left < right) {
            if (s[left++] != s[right--]) {
                return false;
            }
        }
        return true;
    }

public:
    std::vector<std::vector<int>> palindromePairs(std::vector<std::string>& words) {
        std::unordered_map<std::string, int> m;
        for (int i = 0; i < words.size(); ++i) {
            m[words[i]] = i;
        }

        std::set<std::vector<int>> s;

        for (int i = 0; i < words.size(); ++i) {
            const std::string& w = words[i];
            for (int j = 0; j <= w.length(); ++j) {
                std::string prefix = w.substr(0, j);
                std::string suffix = w.substr(j);

                if (isPalindrome(prefix)) {
                    std::string suffix_rev = suffix;
                    std::reverse(suffix_rev.begin(), suffix_rev.end());
                    if (m.count(suffix_rev) && m[suffix_rev] != i) {
                        s.insert({m[suffix_rev], i});
                    }
                }

                if (isPalindrome(suffix)) {
                    std::string prefix_rev = prefix;
                    std::reverse(prefix_rev.begin(), prefix_rev.end());
                    if (m.count(prefix_rev) && m[prefix_rev] != i) {
                        s.insert({i, m[prefix_rev]});
                    }
                }
            }
        }

        std::vector<std::vector<int>> result(s.begin(), s.end());
        return result;
    }
};