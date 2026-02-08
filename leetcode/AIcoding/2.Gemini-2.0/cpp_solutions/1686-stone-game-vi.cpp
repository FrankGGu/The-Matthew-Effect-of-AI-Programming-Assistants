#include <vector>
#include <algorithm>

using namespace std;

int stoneGameVI(vector<int>& aliceValues, vector<int>& bobValues) {
    int n = aliceValues.size();
    vector<pair<int, int>> combined(n);
    for (int i = 0; i < n; ++i) {
        combined[i] = {aliceValues[i] + bobValues[i], i};
    }

    sort(combined.rbegin(), combined.rend());

    int aliceScore = 0;
    int bobScore = 0;

    for (int i = 0; i < n; ++i) {
        if (i % 2 == 0) {
            aliceScore += aliceValues[combined[i].second];
        } else {
            bobScore += bobValues[combined[i].second];
        }
    }

    if (aliceScore > bobScore) {
        return 1;
    } else if (aliceScore < bobScore) {
        return -1;
    } else {
        return 0;
    }
}