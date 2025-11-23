#include <vector>
#include <algorithm>
#include <set>

using namespace std;

vector<string> numMovesStones(int a, int b, int c) {
    vector<int> stones = {a, b, c};
    sort(stones.begin(), stones.end());
    int minStone = stones[0], midStone = stones[1], maxStone = stones[2];

    int minMoves = 0;
    if (midStone - minStone == 1 && maxStone - midStone == 1) {
        minMoves = 0;
    } else if (midStone - minStone <= 2 || maxStone - midStone <= 2) {
        minMoves = 1;
    } else {
        minMoves = 2;
    }

    int maxMoves = (maxStone - minStone) - 2;

    return {to_string(minMoves), to_string(maxMoves)};
}