#include <iostream>
#include <vector>
#include <string>
#include <queue>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    string longestSubsequenceRepeatedK(const string& s, int k) {
        vector<char> chars;
        for (char c : s) {
            if (find(chars.begin(), chars.end(), c) == chars.end()) {
                chars.push_back(c);
            }
        }

        queue<string> q;
        q.push("");

        while (!q.empty()) {
            string curr = q.front();
            q.pop();

            for (char c : chars) {
                string next = curr + c;
                if (isRepeated(next, s, k)) {
                    q.push(next);
                }
            }
        }

        return "";
    }

private:
    bool isRepeated(const string& sub, const string& s, int k) {
        int count = 0;
        int i = 0;
        for (int j = 0; j < s.length(); ++j) {
            if (s[j] == sub[i]) {
                ++i;
                if (i == sub.length()) {
                    ++count;
                    i = 0;
                }
            }
        }
        return count >= k;
    }
};