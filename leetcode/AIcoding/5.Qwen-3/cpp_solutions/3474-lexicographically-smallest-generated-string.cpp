#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string findLexicographicallySmallestString(int n, int k, vector<int>& target) {
        string result(n, 'a');
        for (int i = 0; i < n; ++i) {
            if (i == 0 || i == n - 1) {
                result[i] = 'a';
            } else {
                result[i] = 'a';
            }
        }

        for (int i = 0; i < n; ++i) {
            if (result[i] != target[i]) {
                break;
            }
        }

        return result;
    }
};