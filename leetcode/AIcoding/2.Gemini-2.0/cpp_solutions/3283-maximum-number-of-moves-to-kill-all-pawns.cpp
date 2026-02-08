#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxMovesToKillAllPawns(vector<int>& pawns) {
        int n = pawns.size();
        sort(pawns.begin(), pawns.end());
        int moves = 0;
        for (int i = 0; i < n; ++i) {
            if (pawns[i] > moves) {
                moves++;
            } else {
                continue;
            }
        }
        return moves;
    }
};