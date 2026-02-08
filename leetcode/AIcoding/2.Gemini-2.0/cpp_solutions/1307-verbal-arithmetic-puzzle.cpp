#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool isSolvable(vector<string>& words, string result) {
        string chars = "";
        vector<bool> leadingZero(26, false);
        vector<int> charMap(26, -1);
        vector<bool> used(10, false);

        for (string& word : words) {
            if (word.length() > 1) {
                leadingZero[word[0] - 'A'] = true;
            }
            for (char c : word) {
                if (chars.find(c) == string::npos) {
                    chars += c;
                }
            }
        }
        if (result.length() > 1) {
            leadingZero[result[0] - 'A'] = true;
        }
        for (char c : result) {
            if (chars.find(c) == string::npos) {
                chars += c;
            }
        }

        if (chars.length() > 10) return false;

        return solve(words, result, chars, 0, charMap, used, leadingZero);
    }

private:
    bool solve(vector<string>& words, string result, string& chars, int index, vector<int>& charMap, vector<bool>& used, vector<bool>& leadingZero) {
        if (index == chars.length()) {
            long long sum = 0;
            for (string& word : words) {
                long long num = 0;
                for (char c : word) {
                    num = num * 10 + charMap[c - 'A'];
                }
                sum += num;
            }

            long long resNum = 0;
            for (char c : result) {
                resNum = resNum * 10 + charMap[c - 'A'];
            }

            return sum == resNum;
        }

        for (int i = 0; i < 10; ++i) {
            if (!used[i]) {
                if (leadingZero[chars[index] - 'A'] && i == 0) continue;

                charMap[chars[index] - 'A'] = i;
                used[i] = true;

                if (solve(words, result, chars, index + 1, charMap, used, leadingZero)) {
                    return true;
                }

                charMap[chars[index] - 'A'] = -1;
                used[i] = false;
            }
        }

        return false;
    }
};