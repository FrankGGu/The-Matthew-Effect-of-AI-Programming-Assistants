#include <vector>
#include <string>
#include <unordered_set>

class Solution {
public:
    std::vector<int> findEvenNumbers(std::vector<int>& digits) {
        std::unordered_set<int> resultSet;
        int n = digits.size();

        for (int i = 0; i < n; ++i) {
            if (digits[i] % 2 == 0) {
                for (int j = 0; j < n; ++j) {
                    if (j != i) {
                        for (int k = 0; k < n; ++k) {
                            if (k != i && k != j && digits[j] != 0) {
                                int num = digits[k] * 100 + digits[j] * 10 + digits[i];
                                resultSet.insert(num);
                            }
                        }
                    }
                }
            }
        }

        std::vector<int> result(resultSet.begin(), resultSet.end());
        std::sort(result.begin(), result.end());
        return result;
    }
};