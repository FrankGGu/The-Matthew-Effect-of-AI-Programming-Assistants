#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

vector<int> findAnagrams(string s, string p) {
    vector<int> result;
    if (s.size() < p.size()) return result;

    unordered_map<char, int> pCount, sCount;
    for (char c : p) pCount[c]++;

    for (int i = 0; i < p.size(); i++) {
        sCount[s[i]]++;
    }

    if (pCount == sCount) result.push_back(0);

    for (int i = p.size(); i < s.size(); i++) {
        sCount[s[i]]++;
        sCount[s[i - p.size()]]--;

        if (sCount[s[i - p.size()]] == 0) {
            sCount.erase(s[i - p.size()]);
        }

        if (pCount == sCount) result.push_back(i - p.size() + 1);
    }

    return result;
}