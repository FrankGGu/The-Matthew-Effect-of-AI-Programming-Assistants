#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> transformArray(int n, vector<int> a) {
        vector<int> result = a;
        for (int i = 1; i < n - 1; ++i) {
            result[i] = a[i - 1] + a[i + 1];
        }
        return result;
    }
};