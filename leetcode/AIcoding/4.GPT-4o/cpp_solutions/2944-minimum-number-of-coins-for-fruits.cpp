#include <vector>
#include <unordered_map>
#include <algorithm>
#include <limits.h>

using namespace std;

int minCoins(vector<int>& fruits) {
    unordered_map<int, int> count;
    for (int fruit : fruits) {
        count[fruit]++;
    }

    int numCoins = 0;
    for (auto& entry : count) {
        numCoins += entry.second / 3;
        numCoins += entry.second % 3 > 0 ? 1 : 0;
    }

    return numCoins;
}