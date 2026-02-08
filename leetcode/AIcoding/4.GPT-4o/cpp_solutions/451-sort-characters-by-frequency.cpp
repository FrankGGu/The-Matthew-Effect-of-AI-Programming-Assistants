#include <string>
#include <unordered_map>
#include <vector>
#include <algorithm>

using namespace std;

string frequencySort(string s) {
    unordered_map<char, int> count;
    for (char c : s) {
        count[c]++;
    }

    vector<pair<char, int>> freq(count.begin(), count.end());
    sort(freq.begin(), freq.end(), [](const pair<char, int>& a, const pair<char, int>& b) {
        return a.second > b.second;
    });

    string result;
    for (const auto& p : freq) {
        result += string(p.second, p.first);
    }

    return result;
}