#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> advantageCount(vector<int>& A, vector<int>& B) {
        vector<int> sortedA = A;
        vector<int> sortedB = B;
        sort(sortedA.begin(), sortedA.end());
        sort(sortedB.begin(), sortedB.end());

        int n = A.size();
        vector<int> result(n);
        int left = 0, right = n - 1;

        for (int i = n - 1; i >= 0; --i) {
            if (sortedA[right] > sortedB[i]) {
                result[i] = sortedA[right];
                right--;
            } else {
                result[i] = sortedA[left];
                left++;
            }
        }

        return result;
    }
};