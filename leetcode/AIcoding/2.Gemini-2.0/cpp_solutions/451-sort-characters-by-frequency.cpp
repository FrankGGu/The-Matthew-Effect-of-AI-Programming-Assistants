#include <string>
#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    string frequencySort(string s) {
        map<char, int> freq;
        for (char c : s) {
            freq[c]++;
        }

        vector<pair<char, int>> vec;
        for (auto const& [key, val] : freq) {
            vec.push_back({key, val});
        }

        sort(vec.begin(), vec.end(), [](const pair<char, int>& a, const pair<char, int>& b) {
            return a.second > b.second;
        });

        string result = "";
        for (auto const& [key, val] : vec) {
            result += string(val, key);
        }

        return result;
    }
};