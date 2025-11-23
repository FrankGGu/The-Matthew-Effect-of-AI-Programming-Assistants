#include <string>
#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    bool closeStrings(string word1, string word2) {
        if (word1.length() != word2.length()) {
            return false;
        }

        map<char, int> freq1;
        map<char, int> freq2;

        for (char c : word1) {
            freq1[c]++;
        }
        for (char c : word2) {
            freq2[c]++;
        }

        vector<int> count1;
        vector<int> count2;

        for (auto const& [key, val] : freq1) {
            count1.push_back(val);
        }
        for (auto const& [key, val] : freq2) {
            count2.push_back(val);
        }

        sort(count1.begin(), count1.end());
        sort(count2.begin(), count2.end());

        if (count1 != count2) {
            return false;
        }

        vector<char> chars1;
        vector<char> chars2;

        for (auto const& [key, val] : freq1) {
            chars1.push_back(key);
        }
        for (auto const& [key, val] : freq2) {
            chars2.push_back(key);
        }

        sort(chars1.begin(), chars1.end());
        sort(chars2.begin(), chars2.end());

        return chars1 == chars2;
    }
};