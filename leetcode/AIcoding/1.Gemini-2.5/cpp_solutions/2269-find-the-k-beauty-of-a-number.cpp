#include <string>
#include <vector>

class Solution {
public:
    int divisorSubstrings(int num, int k) {
        std::string s = std::to_string(num);
        int n = s.length();
        int kBeautyCount = 0;

        for (int i = 0; i <= n - k; ++i) {
            std::string subStr = s.substr(i, k);
            int subNum = std::stoi(subStr);

            if (subNum != 0 && num % subNum == 0) {
                kBeautyCount++;
            }
        }

        return kBeautyCount;
    }
};