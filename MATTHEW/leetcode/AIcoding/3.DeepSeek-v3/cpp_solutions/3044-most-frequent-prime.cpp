#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <cmath>

using namespace std;

class Solution {
public:
    vector<int> mostFrequentPrime(vector<vector<int>>& mat) {
        int m = mat.size();
        if (m == 0) return {};
        int n = mat[0].size();
        unordered_map<int, int> freq;
        vector<pair<int, int>> directions = {
            {-1, -1}, {-1, 0}, {-1, 1},
            {0, -1},           {0, 1},
            {1, -1},  {1, 0}, {1, 1}
        };

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                for (auto& dir : directions) {
                    int dx = dir.first, dy = dir.second;
                    int x = i, y = j;
                    int num = 0;
                    while (x >= 0 && x < m && y >= 0 && y < n) {
                        num = num * 10 + mat[x][y];
                        if (num > 10 && isPrime(num)) {
                            freq[num]++;
                        }
                        x += dx;
                        y += dy;
                    }
                }
            }
        }

        if (freq.empty()) return {};

        int max_freq = 0;
        for (auto& p : freq) {
            max_freq = max(max_freq, p.second);
        }

        vector<int> candidates;
        for (auto& p : freq) {
            if (p.second == max_freq) {
                candidates.push_back(p.first);
            }
        }

        sort(candidates.begin(), candidates.end(), greater<int>());

        return candidates;
    }

private:
    bool isPrime(int num) {
        if (num <= 1) return false;
        if (num == 2) return true;
        if (num % 2 == 0) return false;
        for (int i = 3; i * i <= num; i += 2) {
            if (num % i == 0) return false;
        }
        return true;
    }
};