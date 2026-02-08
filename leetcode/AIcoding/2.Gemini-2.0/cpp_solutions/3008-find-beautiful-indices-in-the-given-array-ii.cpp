#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<int> beautifulIndices(string s, string a, string b, int k) {
        vector<int> indicesA, indicesB, result;
        int n = s.length(), lenA = a.length(), lenB = b.length();

        for (int i = 0; i <= n - lenA; ++i) {
            if (s.substr(i, lenA) == a) {
                indicesA.push_back(i);
            }
        }

        for (int i = 0; i <= n - lenB; ++i) {
            if (s.substr(i, lenB) == b) {
                indicesB.push_back(i);
            }
        }

        for (int i : indicesA) {
            bool found = false;
            for (int j : indicesB) {
                if (abs(i - j) <= k) {
                    found = true;
                    break;
                }
            }
            if (found) {
                result.push_back(i);
            }
        }

        return result;
    }
};