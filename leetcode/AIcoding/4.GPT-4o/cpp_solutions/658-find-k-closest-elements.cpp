#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> findClosestElements(vector<int>& arr, int k, int x) {
        auto comp = [&](int a, int b) {
            return abs(a - x) == abs(b - x) ? a < b : abs(a - x) < abs(b - x);
        };

        sort(arr.begin(), arr.end(), comp);
        arr.resize(k);
        sort(arr.begin(), arr.end());

        return arr;
    }
};