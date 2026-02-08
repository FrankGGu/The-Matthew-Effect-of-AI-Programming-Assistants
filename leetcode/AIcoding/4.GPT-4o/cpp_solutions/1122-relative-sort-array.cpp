#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

vector<int> relativeSortArray(vector<int>& arr1, vector<int>& arr2) {
    unordered_map<int, int> count;
    vector<int> result;

    for (int num : arr1) {
        count[num]++;
    }

    for (int num : arr2) {
        while (count[num]--) {
            result.push_back(num);
        }
    }

    vector<int> remaining;
    for (auto& [num, cnt] : count) {
        while (cnt--) {
            remaining.push_back(num);
        }
    }

    sort(remaining.begin(), remaining.end());
    result.insert(result.end(), remaining.begin(), remaining.end());

    return result;
}