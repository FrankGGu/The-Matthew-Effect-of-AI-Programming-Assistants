#include <vector>
#include <string>
#include <algorithm>

class Solution {
public:
    std::string largestTimeFromDigits(std::vector<int>& A) {
        std::string result = "";
        std::sort(A.begin(), A.end());
        do {
            std::string time = std::to_string(A[0]) + std::to_string(A[1]) + ":" + std::to_string(A[2]) + std::to_string(A[3]);
            if (time[0] <= '2' && (time[0] != '2' || time[1] <= '3') && time[3] <= '9' && time[2] <= '5') {
                result = std::max(result, time);
            }
        } while (std::next_permutation(A.begin(), A.end()));
        return result.empty() ? "" : result;
    }
};