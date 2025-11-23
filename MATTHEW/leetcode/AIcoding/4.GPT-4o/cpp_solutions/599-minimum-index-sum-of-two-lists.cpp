#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

vector<string> findRestaurant(vector<string>& list1, vector<string>& list2) {
    unordered_map<string, int> indexSum;
    for (int i = 0; i < list1.size(); ++i) {
        indexSum[list1[i]] = i;
    }
    vector<string> result;
    int minSum = INT_MAX;

    for (int j = 0; j < list2.size(); ++j) {
        if (indexSum.find(list2[j]) != indexSum.end()) {
            int sum = j + indexSum[list2[j]];
            if (sum < minSum) {
                minSum = sum;
                result = {list2[j]};
            } else if (sum == minSum) {
                result.push_back(list2[j]);
            }
        }
    }

    return result;
}