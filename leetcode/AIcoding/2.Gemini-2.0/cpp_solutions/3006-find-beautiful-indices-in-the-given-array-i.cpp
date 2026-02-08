#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> beautifulIndices(string s, string a, string b, int k) {
        vector<int> indices_a;
        vector<int> indices_b;
        vector<int> result;

        for (int i = 0; i + a.size() <= s.size(); ++i) {
            if (s.substr(i, a.size()) == a) {
                indices_a.push_back(i);
            }
        }

        for (int i = 0; i + b.size() <= s.size(); ++i) {
            if (s.substr(i, b.size()) == b) {
                indices_b.push_back(i);
            }
        }

        for (int i = 0; i < indices_a.size(); ++i) {
            bool found = false;
            for (int j = 0; j < indices_b.size(); ++j) {
                if (abs(indices_a[i] - indices_b[j]) <= k) {
                    found = true;
                    break;
                }
            }
            if (found) {
                result.push_back(indices_a[i]);
            }
        }

        return result;
    }
};