#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> minOperations(vector<string>& boxes) {
        int n = boxes.size();
        vector<int> result(n, 0);
        vector<int> left(n, 0);
        vector<int> right(n, 0);

        int count = 0;
        for (int i = 0; i < n; ++i) {
            left[i] = count;
            if (boxes[i] == '1') {
                ++count;
            }
        }

        count = 0;
        for (int i = n - 1; i >= 0; --i) {
            right[i] = count;
            if (boxes[i] == '1') {
                ++count;
            }
        }

        for (int i = 0; i < n; ++i) {
            result[i] = left[i] + right[i];
        }

        return result;
    }
};