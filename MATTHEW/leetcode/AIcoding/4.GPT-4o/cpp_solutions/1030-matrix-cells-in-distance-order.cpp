#include <vector>
#include <algorithm>

using namespace std;

vector<vector<int>> allCellsDistOrder(int R, int C, int r0, int c0) {
    vector<vector<int>> cells;
    for (int r = 0; r < R; ++r) {
        for (int c = 0; c < C; ++c) {
            cells.push_back({r, c});
        }
    }
    sort(cells.begin(), cells.end(), [r0, c0](const vector<int>& a, const vector<int>& b) {
        int distA = abs(a[0] - r0) + abs(a[1] - c0);
        int distB = abs(b[0] - r0) + abs(b[1] - c0);
        return distA < distB;
    });
    return cells;
}