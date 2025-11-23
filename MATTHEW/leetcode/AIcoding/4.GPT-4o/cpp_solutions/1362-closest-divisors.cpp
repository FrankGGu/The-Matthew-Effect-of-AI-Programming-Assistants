#include <vector>
#include <cmath>
using namespace std;

class Solution {
public:
    vector<int> closestDivisors(int num) {
        int n1 = num + 1, n2 = num + 2;
        return findClosestDivisor(n1, n2);
    }

    vector<int> findClosestDivisor(int n1, int n2) {
        vector<int> res1, res2;
        int sqrt1 = sqrt(n1), sqrt2 = sqrt(n2);

        for (int i = sqrt1; i >= 1; --i) {
            if (n1 % i == 0) {
                res1 = {i, n1 / i};
                break;
            }
        }

        for (int i = sqrt2; i >= 1; --i) {
            if (n2 % i == 0) {
                res2 = {i, n2 / i};
                break;
            }
        }

        return (abs(res1[0] - res1[1]) <= abs(res2[0] - res2[1])) ? res1 : res2;
    }
};