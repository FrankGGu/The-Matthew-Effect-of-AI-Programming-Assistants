#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool makeEqual(vector<string>& words) {
        unordered_map<char, int> counts;
        for (const string& word : words) {
            for (char c : word) {
                counts[c]++;
            }
        }

        int n = words.size();
        for (auto const& [key, val] : counts) {
            if (val % n != 0) {
                return false;
            }
        }

        return true;
    }
};