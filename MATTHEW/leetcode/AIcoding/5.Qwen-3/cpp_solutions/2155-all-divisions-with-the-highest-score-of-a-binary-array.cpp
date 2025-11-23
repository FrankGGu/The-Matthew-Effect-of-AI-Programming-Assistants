#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> maxScoreIndices(vector<int>& arr) {
        int n = arr.size();
        int leftZero = 0;
        int leftOne = 0;
        int rightZero = 0;
        int rightOne = 0;

        for (int i = 0; i < n; ++i) {
            if (arr[i] == 0) rightZero++;
            else rightOne++;
        }

        vector<int> result;
        int maxScore = -1;

        for (int i = 0; i <= n; ++i) {
            int score = leftZero + rightOne;
            if (score > maxScore) {
                maxScore = score;
                result.clear();
                result.push_back(i);
            } else if (score == maxScore) {
                result.push_back(i);
            }

            if (i < n) {
                if (arr[i] == 0) leftZero++;
                else leftOne++;
                if (arr[i] == 0) rightZero--;
                else rightOne--;
            }
        }

        return result;
    }
};