#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

vector<int> findOriginalArray(vector<int>& changed) {
    if (changed.size() % 2 != 0) return {};

    unordered_map<int, int> count;
    for (int num : changed) {
        count[num]++;
    }

    vector<int> original;
    sort(changed.begin(), changed.end());

    for (int num : changed) {
        if (count[num] == 0) continue;
        if (count[num * 2] == 0) return {};

        original.push_back(num);
        count[num]--;
        count[num * 2]--;
    }

    return original;
}