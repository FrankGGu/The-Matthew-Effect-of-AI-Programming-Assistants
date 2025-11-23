class Solution {
public:
    std::string largestGoodInteger(std::string num) {
        std::string result = "";
        for (int i = 0; i <= num.length() - 3; ++i) {
            if (num[i] == num[i+1] && num[i+1] == num[i+2]) {
                if (result.empty() || num[i] > result[0]) {
                    result = num.substr(i, 3);
                }
            }
        }
        return result;
    }
};