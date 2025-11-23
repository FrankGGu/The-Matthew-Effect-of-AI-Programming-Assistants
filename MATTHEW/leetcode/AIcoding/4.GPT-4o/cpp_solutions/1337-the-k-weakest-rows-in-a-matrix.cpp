#include <vector>
#include <algorithm>
#include <utility>

using namespace std;

vector<int> kWeakestRows(vector<vector<int>>& mat, int k) {
    vector<pair<int, int>> rowStrength;
    for (int i = 0; i < mat.size(); ++i) {
        int count = count(mat[i].begin(), mat[i].end(), 1);
        rowStrength.emplace_back(count, i);
    }
    sort(rowStrength.begin(), rowStrength.end());
    vector<int> result;
    for (int i = 0; i < k; ++i) {
        result.push_back(rowStrength[i].second);
    }
    return result;
}