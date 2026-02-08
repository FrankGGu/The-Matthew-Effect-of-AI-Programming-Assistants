#include <vector>
#include <string>
using namespace std;

class Solution {
public:
    vector<int> minOperations(string boxes) {
        int n = boxes.size();
        vector<int> result(n, 0);
        int leftCount = 0, rightCount = 0, leftOperations = 0, rightOperations = 0;

        for (int i = 0; i < n; ++i) {
            result[i] += leftOperations;
            if (boxes[i] == '1') leftCount++;
            leftOperations += leftCount;
        }

        for (int i = n - 1; i >= 0; --i) {
            result[i] += rightOperations;
            if (boxes[i] == '1') rightCount++;
            rightOperations += rightCount;
        }

        return result;
    }
};