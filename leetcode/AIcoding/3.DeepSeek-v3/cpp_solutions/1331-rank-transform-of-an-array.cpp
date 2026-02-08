#include <vector>
#include <algorithm>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> arrayRankTransform(vector<int>& arr) {
        if (arr.empty()) return {};
        vector<int> sortedArr = arr;
        sort(sortedArr.begin(), sortedArr.end());
        unordered_map<int, int> rankMap;
        int rank = 1;
        for (int i = 0; i < sortedArr.size(); ++i) {
            if (i == 0 || sortedArr[i] != sortedArr[i-1]) {
                rankMap[sortedArr[i]] = rank++;
            }
        }
        vector<int> result;
        for (int num : arr) {
            result.push_back(rankMap[num]);
        }
        return result;
    }
};