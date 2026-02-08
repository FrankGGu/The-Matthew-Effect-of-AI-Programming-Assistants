#include <vector>
#include <algorithm>

class Solution {
public:
    int tilingRectangle(int n, int m) {
        if (n == m) {
            return 1;
        }
        if (n > m) {
            std::swap(n, m);
        }
        this->n_ = m;
        this->m_ = n;
        ans = n_ * m_;
        std::vector<int> skyline(m_, 0);
        dfs(skyline, 0);
        return ans;
    }

private:
    int ans;
    int n_, m_;

    void dfs(std::vector<int>& skyline, int count) {
        if (count >= ans) {
            return;
        }

        int min_h = n_;
        int start_col = -1;
        for (int i = 0; i < m_; ++i) {
            if (skyline[i] < min_h) {
                min_h = skyline[i];
                start_col = i;
            }
        }

        if (min_h == n_) {
            ans = count;
            return;
        }

        int end_col = start_col;
        while (end_col < m_ && skyline[end_col] == min_h) {
            end_col++;
        }

        int width = end_col - start_col;
        int max_size = std::min(width, n_ - min_h);

        for (int size = max_size; size >= 1; --size) {
            for (int i = start_col; i < start_col + size; ++i) {
                skyline[i] += size;
            }
            dfs(skyline, count + 1);
            for (int i = start_col; i < start_col + size; ++i) {
                skyline[i] -= size;
            }
        }
    }
};