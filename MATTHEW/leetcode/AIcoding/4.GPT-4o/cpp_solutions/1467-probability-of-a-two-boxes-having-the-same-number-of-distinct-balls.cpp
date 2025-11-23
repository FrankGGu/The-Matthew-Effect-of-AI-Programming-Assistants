#include <vector>
#include <unordered_map>
#include <numeric>

class Solution {
public:
    double getProbability(std::vector<int>& boxes1, std::vector<int>& boxes2) {
        std::unordered_map<int, int> count1, count2;
        int totalBalls = 0;

        for (int b : boxes1) {
            count1[b]++;
            totalBalls++;
        }
        for (int b : boxes2) {
            count2[b]++;
            totalBalls++;
        }

        int distinct1 = count1.size();
        int distinct2 = count2.size();

        if (distinct1 != distinct2) return 0.0;

        return static_cast<double>(factorial(totalBalls)) /
               (factorial(totalBalls / 2) * factorial(totalBalls / 2));
    }

private:
    int factorial(int n) {
        if (n <= 1) return 1;
        int result = 1;
        for (int i = 2; i <= n; ++i) {
            result *= i;
        }
        return result;
    }
};