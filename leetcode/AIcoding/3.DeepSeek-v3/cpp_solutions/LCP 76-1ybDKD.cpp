#include <vector>
#include <cmath>
#include <climits>
using namespace std;

class Solution {
public:
    double minRecSize(vector<vector<int>>& lines) {
        vector<double> A, B, C, D;
        for (auto& l : lines) {
            int k = l[0], b = l[1];
            if (k > 0) {
                A.push_back(-1.0 * b / k);
                B.push_back(-1.0 * (b + 1) / k);
            } else if (k < 0) {
                C.push_back(-1.0 * b / k);
                D.push_back(-1.0 * (b + 1) / k);
            }
        }

        if (A.empty() || C.empty()) return 0;

        sort(A.begin(), A.end());
        sort(B.begin(), B.end());
        sort(C.begin(), C.end());
        sort(D.begin(), D.end());

        double minA = A.front(), maxA = A.back();
        double minB = B.front(), maxB = B.back();
        double minC = C.front(), maxC = C.back();
        double minD = D.front(), maxD = D.back();

        double x1 = max(minA, minC);
        double x2 = min(maxA, maxC);
        double y1 = max(minB, minD);
        double y2 = min(maxB, maxD);

        if (x1 >= x2 || y1 >= y2) return 0;

        return (x2 - x1) * (y2 - y1);
    }
};