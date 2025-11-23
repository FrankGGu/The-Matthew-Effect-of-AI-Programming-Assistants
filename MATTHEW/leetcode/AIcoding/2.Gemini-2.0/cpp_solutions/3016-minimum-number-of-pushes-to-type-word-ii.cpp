#include <string>
#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    int minimumPushes(string word) {
        map<char, int> freq;
        for (char c : word) {
            freq[c]++;
        }

        vector<int> counts;
        for (auto const& [key, val] : freq) {
            counts.push_back(val);
        }

        sort(counts.rbegin(), counts.rend());

        int pushes = 0;
        int numChars = counts.size();

        for (int i = 0; i < min(numChars, 8); ++i) {
            pushes += counts[i];
        }
        for (int i = 8; i < min(numChars, 16); ++i) {
            pushes += 2 * counts[i];
        }
        for (int i = 16; i < min(numChars, 24); ++i) {
            pushes += 3 * counts[i];
        }
        for (int i = 24; i < numChars; ++i) {
            pushes += 4 * counts[i];
        }

        return pushes;
    }
};