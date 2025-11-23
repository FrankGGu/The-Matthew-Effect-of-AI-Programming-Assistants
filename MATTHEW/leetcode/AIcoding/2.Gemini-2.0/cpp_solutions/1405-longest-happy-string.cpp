#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string longestDiverseString(int a, int b, int c) {
        string res = "";
        vector<pair<int, char>> counts = {{a, 'a'}, {b, 'b'}, {c, 'c'}};

        while (true) {
            sort(counts.begin(), counts.end(), greater<pair<int, char>>());

            bool added = false;
            for (int i = 0; i < 3; ++i) {
                if (counts[i].first <= 0) break;

                if (res.length() >= 2 && res[res.length() - 1] == counts[i].second && res[res.length() - 2] == counts[i].second) {
                    continue;
                }

                res += counts[i].second;
                counts[i].first--;
                added = true;
                break;
            }

            if (!added) break;
        }

        return res;
    }
};