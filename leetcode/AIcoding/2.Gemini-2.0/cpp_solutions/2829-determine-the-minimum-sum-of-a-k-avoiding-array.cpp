#include <vector>
#include <numeric>
#include <algorithm>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int minimumSum(int n, int k) {
        unordered_set<int> used;
        vector<int> arr;
        int num = 1;
        while (arr.size() < n) {
            if (used.find(num) == used.end()) {
                arr.push_back(num);
                used.insert(k - num);
            }
            num++;
        }
        return accumulate(arr.begin(), arr.end(), 0);
    }
};