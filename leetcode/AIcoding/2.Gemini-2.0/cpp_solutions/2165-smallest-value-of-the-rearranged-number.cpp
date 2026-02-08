#include <algorithm>
#include <string>
#include <vector>

class Solution {
public:
  long long smallestNumber(long long num) {
    if (num == 0) {
      return 0;
    }

    std::string s = std::to_string(std::abs(num));
    std::sort(s.begin(), s.end());

    if (num > 0) {
      int firstNonZero = 0;
      while (firstNonZero < s.length() && s[firstNonZero] == '0') {
        firstNonZero++;
      }
      if (firstNonZero < s.length()) {
        std::swap(s[0], s[firstNonZero]);
      }
      return std::stoll(s);
    } else {
      std::reverse(s.begin(), s.end());
      return -std::stoll(s);
    }
  }
};