#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int getMaximumScore(vector<int>& A, vector<int>& B) {
        int i = 0, j = 0;
        int score = 0;
        while (i < A.size() && j < B.size()) {
            if (A[i] < B[j]) {
                score += A[i];
                i++;
            } else if (A[i] > B[j]) {
                score -= B[j];
                j++;
            } else {
                i++;
                j++;
            }
        }
        while (i < A.size()) {
            score += A[i];
            i++;
        }
        while (j < B.size()) {
            score -= B[j];
            j++;
        }
        return score;
    }
};