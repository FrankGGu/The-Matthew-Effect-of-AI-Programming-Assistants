#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string minimumSubtreePartition(string s) {
        int n = s.length();
        vector<int> freq(26, 0);
        for (char c : s) {
            freq[c - 'a']++;
        }

        vector<int> left(26, 0);
        vector<int> right(26, 0);
        for (int i = 0; i < 26; i++) {
            right[i] = freq[i];
        }

        int minLen = n;
        string result = s;

        for (int i = 0; i < n; i++) {
            char c = s[i];
            left[c - 'a']++;
            right[c - 'a']--;

            bool valid = true;
            for (int j = 0; j < 26; j++) {
                if (left[j] != 0 && right[j] != 0) {
                    valid = false;
                    break;
                }
            }

            if (valid) {
                string sub = s.substr(0, i + 1);
                if (sub.length() < minLen) {
                    minLen = sub.length();
                    result = sub;
                }
            }
        }

        return result;
    }
};