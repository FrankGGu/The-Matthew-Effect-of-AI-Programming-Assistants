#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minDeletions(string s, int k) {
        unordered_map<char, int> freq;
        for (char c : s) {
            freq[c]++;
        }

        vector<int> counts;
        for (auto const& [key, val] : freq) {
            counts.push_back(val);
        }

        sort(counts.begin(), counts.end(), greater<int>());

        int deletions = 0;
        while (counts.size() > k) {
            deletions += counts.back();
            counts.pop_back();
        }

        return deletions;
    }
};