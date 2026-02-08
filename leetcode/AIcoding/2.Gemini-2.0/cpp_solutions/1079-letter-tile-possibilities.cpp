#include <string>
#include <vector>
#include <algorithm>
#include <set>

using namespace std;

class Solution {
public:
    int numTilePossibilities(string tiles) {
        sort(tiles.begin(), tiles.end());
        set<string> result;
        string current;
        vector<bool> used(tiles.length(), false);

        function<void(void)> backtrack = [&]() {
            if (!current.empty()) {
                result.insert(current);
            }

            for (int i = 0; i < tiles.length(); ++i) {
                if (used[i]) continue;
                used[i] = true;
                current += tiles[i];
                backtrack();
                current.pop_back();
                used[i] = false;
            }
        };

        backtrack();
        return result.size();
    }
};