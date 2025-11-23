class Solution {
private:
    std::vector<bool> is_prime;

    void sieve(int n) {
        is_prime.assign(n + 1, true);
        is_prime[0] = is_prime[1] = false;
        for (int p = 2; p * p <= n; ++p) {
            if (is_prime[p]) {
                for (int i = p * p; i <= n; i += p) {
                    is_prime[i] = false;
                }
            }
        }
    }

public:
    int mostFrequentPrime(std::vector<std::vector<int>>& mat) {
        sieve(1000000);
        int m = mat.size();
        int n = mat[0].size();
        std::unordered_map<int, int> freq;

        const int dr[] = {-1, -1, -1, 0, 0, 1, 1, 1};
        const int dc[] = {-1, 0, 1, -1, 1, -1, 0, 1};

        for (int r = 0; r < m; ++r) {
            for (int c = 0; c < n; ++c) {
                for (int i = 0; i < 8; ++i) {
                    int current_num = mat[r][c];
                    int nr = r + dr[i];
                    int nc = c + dc[i];
                    while (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                        current_num = current_num * 10 + mat[nr][nc];
                        if (is_prime[current_num]) {
                            freq[current_num]++;
                        }
                        nr += dr[i];
                        nc += dc[i];
                    }
                }
            }
        }

        if (freq.empty()) {
            return -1;
        }

        int max_freq = 0;
        int result_prime = -1;

        for (auto const& [num, count] : freq) {
            if (count > max_freq) {
                max_freq = count;
                result_prime = num;
            } else if (count == max_freq) {
                result_prime = std::max(result_prime, num);
            }
        }

        return result_prime;
    }
};