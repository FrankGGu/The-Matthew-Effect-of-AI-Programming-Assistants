#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> beautifulArray(int n) {
        vector<int> result;
        if (n == 0) return result;
        result.push_back(1);
        for (int i = 2; i <= n; i++) {
            vector<int> temp;
            for (int num : result) {
                temp.push_back(num * 2 - 1);
            }
            for (int num : result) {
                temp.push_back(num * 2);
            }
            result = temp;
        }
        return result;
    }
};