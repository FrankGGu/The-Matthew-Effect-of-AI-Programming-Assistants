#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int get_value(string s, vector<int>& mapping) {
        int res = 0;
        for (char c : s) {
            res = res * 10 + mapping[c - 'a'];
        }
        return res;
    }

    bool isSolvable(vector<string>& words, string result) {
        string chars = "";
        vector<int> freq(26, 0);
        vector<bool> leading(26, false);

        for (string word : words) {
            if (word.length() > 1) {
                leading[word[0] - 'a'] = true;
            }
            for (char c : word) {
                freq[c - 'a']++;
                if (chars.find(c) == string::npos) {
                    chars += c;
                }
            }
        }

        if (result.length() > 1) {
            leading[result[0] - 'a'] = true;
        }
        for (char c : result) {
            freq[c - 'a']++;
            if (chars.find(c) == string::npos) {
                chars += c;
            }
        }

        vector<int> mapping(26, -1);
        vector<bool> used(10, false);

        return solve(words, result, chars, 0, mapping, used, leading);
    }

    bool solve(vector<string>& words, string result, string chars, int idx, vector<int>& mapping, vector<bool>& used, vector<bool>& leading) {
        if (idx == chars.length()) {
            int sum = 0;
            for (string word : words) {
                sum += get_value(word, mapping);
            }
            return sum == get_value(result, mapping);
        }

        char c = chars[idx];
        for (int i = 0; i <= 9; ++i) {
            if (!used[i]) {
                if (i == 0 && leading[c - 'a']) continue;
                mapping[c - 'a'] = i;
                used[i] = true;
                if (solve(words, result, chars, idx + 1, mapping, used, leading)) {
                    return true;
                }
                mapping[c - 'a'] = -1;
                used[i] = false;
            }
        }

        return false;
    }
};