#include <string>
#include <sstream>
#include <vector>
#include <numeric>
#include <cmath>

class Solution {
public:
    std::string fractionAddition(std::string expression) {
        std::vector<int> numerators, denominators;
        std::stringstream ss(expression);
        std::string token;

        while (std::getline(ss, token, '+')) {
            std::stringstream ss2(token);
            std::string subtoken;
            while (std::getline(ss2, subtoken, '-')) {
                if (!subtoken.empty()) {
                    auto pos = subtoken.find('/');
                    int num = std::stoi(subtoken.substr(0, pos));
                    int den = std::stoi(subtoken.substr(pos + 1));
                    numerators.push_back(num);
                    denominators.push_back(den);
                }
                if (ss2.peek() == '-') {
                    ss2.get();
                    if (!std::getline(ss2, subtoken, '+')) break;
                    auto pos = subtoken.find('/');
                    int num = -std::stoi(subtoken.substr(0, pos));
                    int den = std::stoi(subtoken.substr(pos + 1));
                    numerators.push_back(num);
                    denominators.push_back(den);
                }
            }
        }

        int lcm = std::accumulate(denominators.begin(), denominators.end(), 1, [](int a, int b) {
            return std::lcm(a, b);
        });

        int sum_numerator = 0;
        for (size_t i = 0; i < numerators.size(); ++i) {
            sum_numerator += numerators[i] * (lcm / denominators[i]);
        }

        int gcd = std::gcd(sum_numerator, lcm);
        return std::to_string(sum_numerator / gcd) + "/" + std::to_string(lcm / gcd);
    }
};