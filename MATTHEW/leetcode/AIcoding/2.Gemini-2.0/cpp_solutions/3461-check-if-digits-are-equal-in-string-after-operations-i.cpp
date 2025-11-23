#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool areAlmostEqual(string s1, string s2) {
        if (s1 == s2) return true;

        vector<int> diff_indices;
        for (int i = 0; i < s1.length(); ++i) {
            if (s1[i] != s2[i]) {
                diff_indices.push_back(i);
            }
        }

        if (diff_indices.size() == 2) {
            swap(s1[diff_indices[0]], s1[diff_indices[1]]);
            return s1 == s2;
        }

        return false;
    }
};