#include <string>
#include <cmath>
#include <algorithm>

class Solution {
private:
    long double powerL(int base, int exp) {
        long double res = 1.0L;
        for (int i = 0; i < exp; ++i) {
            res *= base;
        }
        return res;
    }

    long double convertToLongDouble(const std::string& s) {
        size_t dot_pos = s.find('.');
        size_t open_paren_pos = s.find('(');

        std::string I_str;
        std::string N_str;
        std::string R_str;

        if (dot_pos == std::string::npos) {
            I_str = s;
        } else {
            I_str = s.substr(0, dot_pos);
            if (open_paren_pos == std::string::npos) {
                N_str = s.substr(dot_pos + 1);
            } else {
                N_str = s.substr(dot_pos + 1, open_paren_pos - (dot_pos + 1));
                R_str = s.substr(open_paren_pos + 1, s.length() - (open_paren_pos + 1) - 1);
            }
        }

        long double I_val = I_str.empty() ? 0.0L : std::stold(I_str);
        long double N_val = N_str.empty() ? 0.0L : std::stold(N_str);
        long double R_val = R_str.empty() ? 0.0L : std::stold(R_str);

        int k = N_str.length();
        int m = R_str.length();

        long double result = I_val;

        if (k > 0) {
            result += N_val / powerL(10, k);
        }

        if (m > 0) {
            result += R_val / (powerL(10, k) * (powerL(10, m) - 1.0L));
        }

        return result;
    }

public:
    bool isRationalEqual(std::string s, std::string t) {
        long double val_s = convertToLongDouble(s);
        long double val_t = convertToLongDouble(t);

        return std::abs(val_s - val_t) < 1e-19L;
    }
};