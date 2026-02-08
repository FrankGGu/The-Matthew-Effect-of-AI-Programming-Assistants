#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string smallestEquivalentString(string s1, string s2, string baseStr) {
        vector<int> parent(26);
        for (int i = 0; i < 26; ++i) {
            parent[i] = i;
        }

        function<int(int)> find = [&](int x) {
            if (parent[x] == x) {
                return x;
            }
            return parent[x] = find(parent[x]);
        };

        auto unite = [&](int x, int y) {
            x = find(x);
            y = find(y);
            if (x != y) {
                if (x < y) {
                    parent[y] = x;
                } else {
                    parent[x] = y;
                }
            }
        };

        for (int i = 0; i < s1.length(); ++i) {
            unite(s1[i] - 'a', s2[i] - 'a');
        }

        string result = "";
        for (char c : baseStr) {
            result += (char)(find(c - 'a') + 'a');
        }

        return result;
    }
};