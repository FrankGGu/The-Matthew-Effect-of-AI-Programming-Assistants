#include <vector>
#include <algorithm>
#include <unordered_map>

class Solution {
public:
    int countSquarefulArrays(std::vector<int>& A) {
        std::sort(A.begin(), A.end());
        std::unordered_map<int, int> count;
        for (int num : A) {
            count[num]++;
        }
        return backtrack(A, count, 0, -1);
    }

private:
    int backtrack(const std::vector<int>& A, std::unordered_map<int, int>& count, int length, int last) {
        if (length == A.size()) {
            return 1;
        }
        int total = 0;
        for (auto& [num, cnt] : count) {
            if (cnt > 0) {
                if (last == -1 || isSquareful(last, num)) {
                    count[num]--;
                    total += backtrack(A, count, length + 1, num);
                    count[num]++;
                }
            }
        }
        return total;
    }

    bool isSquareful(int a, int b) {
        int sum = a + b;
        int sq = (int)sqrt(sum);
        return sq * sq == sum;
    }
};