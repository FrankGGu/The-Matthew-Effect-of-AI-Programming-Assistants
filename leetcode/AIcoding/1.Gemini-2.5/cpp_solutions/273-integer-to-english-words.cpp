#include <string>
#include <vector>
#include <algorithm>

class Solution {
private:
    std::vector<std::string> lessThan20 = {
        "", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten",
        "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"
    };
    std::vector<std::string> tens = {
        "", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"
    };
    std::vector<std::string> thousands = {
        "", "Thousand", "Million", "Billion"
    };

    std::string helper(int num) {
        if (num == 0) {
            return "";
        } else if (num < 20) {
            return lessThan20[num];
        } else if (num < 100) {
            return tens[num / 10] + (num % 10 != 0 ? " " + lessThan20[num % 10] : "");
        } else {
            return lessThan20[num / 100] + " Hundred" + (num % 100 != 0 ? " " + helper(num % 100) : "");
        }
    }

public:
    std::string numberToWords(int num) {
        if (num == 0) {
            return "Zero";
        }

        std::string result = "";
        int i = 0;

        while (num > 0) {
            int chunk = num % 1000;
            if (chunk != 0) {
                std::string currentChunkWords = helper(chunk);
                std::string currentSuffix = thousands[i];

                if (!result.empty()) {
                    result = currentChunkWords + (currentSuffix.empty() ? "" : " " + currentSuffix) + " " + result;
                } else {
                    result = currentChunkWords + (currentSuffix.empty() ? "" : " " + currentSuffix);
                }
            }
            num /= 1000;
            i++;
        }
        return result;
    }
};