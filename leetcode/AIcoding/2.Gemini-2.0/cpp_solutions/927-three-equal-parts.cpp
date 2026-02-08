#include <vector>

using namespace std;

class Solution {
public:
    vector<int> threeEqualParts(vector<int>& arr) {
        int n = arr.size();
        int ones = 0;
        for (int x : arr) {
            ones += x;
        }

        if (ones % 3 != 0) {
            return {-1, -1};
        }

        if (ones == 0) {
            return {0, 2};
        }

        int target = ones / 3;
        int first = -1, second = -1, third = -1;
        int count = 0;
        for (int i = 0; i < n; ++i) {
            if (arr[i] == 1) {
                count++;
                if (count == 1) {
                    first = i;
                } else if (count == target + 1) {
                    second = i;
                } else if (count == 2 * target + 1) {
                    third = i;
                }
            }
        }

        while (third < n && arr[first] == arr[second] && arr[second] == arr[third]) {
            first++;
            second++;
            third++;
        }

        if (third == n) {
            return {first - 1, second};
        } else {
            return {-1, -1};
        }
    }
};