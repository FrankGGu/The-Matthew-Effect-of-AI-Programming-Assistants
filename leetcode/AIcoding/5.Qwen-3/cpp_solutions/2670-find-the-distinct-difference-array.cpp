#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> distinctDifferenceArray(string s) {
        int n = s.size();
        vector<int> result(n, 0);

        for (int i = 0; i < n; ++i) {
            unordered_map<char, int> left;
            for (int j = 0; j <= i; ++j) {
                left[s[j]]++;
            }

            unordered_map<char, int> right;
            for (int j = i + 1; j < n; ++j) {
                right[s[j]]++;
            }

            int leftUnique = left.size();
            int rightUnique = right.size();
            result[i] = leftUnique - rightUnique;
        }

        return result;
    }
};