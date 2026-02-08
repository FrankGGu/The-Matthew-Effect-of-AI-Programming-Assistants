#include <iostream>
#include <vector>
#include <string>
#include <cmath>

using namespace std;

class Solution {
public:
    string pushDominoes(string dominoes) {
        int n = dominoes.size();
        vector<int> left(n, 0), right(n, 0);

        int count = 0;
        for (int i = 0; i < n; i++) {
            if (dominoes[i] == 'R') {
                count = 1;
            } else if (dominoes[i] == 'L') {
                count = 0;
            } else {
                right[i] = count;
            }
        }

        count = 0;
        for (int i = n - 1; i >= 0; i--) {
            if (dominoes[i] == 'L') {
                count = 1;
            } else if (dominoes[i] == 'R') {
                count = 0;
            } else {
                left[i] = count;
            }
        }

        string result;
        for (int i = 0; i < n; i++) {
            if (right[i] > left[i]) {
                result += 'R';
            } else if (left[i] > right[i]) {
                result += 'L';
            } else {
                result += '.';
            }
        }

        return result;
    }
};