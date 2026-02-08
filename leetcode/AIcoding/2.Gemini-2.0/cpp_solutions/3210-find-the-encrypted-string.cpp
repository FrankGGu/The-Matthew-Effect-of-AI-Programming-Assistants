#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    string findEncryptedString(string s, int k) {
        int n = s.length();
        string encrypted = "";
        vector<string> substrings;

        for (int i = 0; i < n; ++i) {
            substrings.push_back(s.substr(i));
        }

        sort(substrings.begin(), substrings.end());

        return substrings[(k - 1) % n];
    }
};