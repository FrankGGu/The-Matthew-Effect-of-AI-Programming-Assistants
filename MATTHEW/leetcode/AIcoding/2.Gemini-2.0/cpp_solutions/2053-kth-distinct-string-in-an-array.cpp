#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string kthDistinct(vector<string>& arr, int k) {
        unordered_map<string, int> counts;
        for (const string& s : arr) {
            counts[s]++;
        }

        vector<string> distinctStrings;
        for (const string& s : arr) {
            if (counts[s] == 1) {
                distinctStrings.push_back(s);
            }
        }

        if (k <= distinctStrings.size()) {
            return distinctStrings[k - 1];
        } else {
            return "";
        }
    }
};