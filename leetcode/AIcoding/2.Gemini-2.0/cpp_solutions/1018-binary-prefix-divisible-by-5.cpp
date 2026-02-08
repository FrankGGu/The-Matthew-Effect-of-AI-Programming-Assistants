#include <vector>

using namespace std;

class Solution {
public:
    vector<bool> prefixesDivBy5(vector<int>& A) {
        vector<bool> result;
        int num = 0;
        for (int bit : A) {
            num = ((num << 1) + bit) % 5;
            result.push_back(num == 0);
        }
        return result;
    }
};