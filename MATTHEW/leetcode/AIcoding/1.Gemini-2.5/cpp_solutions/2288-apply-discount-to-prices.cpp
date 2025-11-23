#include <string>
#include <sstream>
#include <iomanip>
#include <vector>
#include <cctype>

class Solution {
public:
    std::string discountPrices(std::string sentence, int discount) {
        std::stringstream ss(sentence);
        std::string word;
        std::stringstream result_ss;
        double discountFactor = 1.0 - discount / 100.0;
        bool first = true;

        while (ss >> word) {
            if (!first) {
                result_ss << " ";
            }
            first = false;

            if (word.length() > 1 && word[0] == '$') {
                bool is_price = true;
                for (size_t i = 1; i < word.length(); ++i) {
                    if (!isdigit(word[i])) {
                        is_price = false;
                        break;
                    }
                }

                if (is_price) {
                    long long price_val = std::stoll(word.substr(1));
                    double discounted_price = price_val * discountFactor;
                    result_ss << '$' << std::fixed << std::setprecision(2) << discounted_price;
                } else {
                    result_ss << word;
                }
            } else {
                result_ss << word;
            }
        }
        return result_ss.str();
    }
};