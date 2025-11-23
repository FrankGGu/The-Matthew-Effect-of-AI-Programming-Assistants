#include <vector>

class Solution {
private:
    long long MOD = 1000000007;
    int size = 10;

    using matrix = std::vector<std::vector<long long>>;

    matrix multiply(const matrix& a, const matrix& b) {
        matrix c(size, std::vector<long long>(size, 0));
        for (int i = 0; i < size; ++i) {
            for (int j = 0; j < size; ++j) {
                for (int k = 0; k < size; ++k) {
                    c[i][j] = (c[i][j] + a[i][k] * b[k][j]) % MOD;
                }
            }
        }
        return c;
    }

    matrix power(matrix base, long long exp) {
        matrix res(size, std::vector<long long>(size, 0));
        for (int i = 0; i < size; ++i) {
            res[i][i] = 1;
        }
        while (exp > 0) {
            if (exp % 2 == 1) {
                res = multiply(res, base);
            }
            base = multiply(base, base);
            exp /= 2;
        }
        return res;
    }

public:
    int passwordCracker(long long n) {
        if (n == 1) {
            return 10;
        }

        matrix T(size, std::vector<long long>(size));
        for (int i = 0; i < size; ++i) {
            for (int j = 0; j < size; ++j) {
                if (i + j <= 9) {
                    T[i][j] = 1;
                } else {
                    T[i][j] = 0;
                }
            }
        }

        matrix M = power(T, n - 1);

        long long total_sum = 0;
        for (int i = 0; i < size; ++i) {
            for (int j = 0; j < size; ++j) {
                total_sum = (total_sum + M[i][j]) % MOD;
            }
        }

        return static_cast<int>(total_sum);
    }
};