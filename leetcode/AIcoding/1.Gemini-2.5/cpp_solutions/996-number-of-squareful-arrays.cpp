#include <vector>
#include <numeric>
#include <cmath>
#include <map>
#include <algorithm>

class Solution {
public:
    int count = 0;
    std::map<int, int> nums_map;
    int n_len;

    bool isPerfectSquare(int num) {
        if (num < 0) return false;
        long long root = static_cast<long long>(sqrt(num));
        return root * root == num;
    }

    void backtrack(std::vector<int>& current_permutation) {
        if (current_permutation.size() == n_len) {
            count++;
            return;
        }

        for (auto& pair : nums_map) {
            int num = pair.first;
            int& freq = pair.second;

            if (freq > 0) {
                if (current_permutation.empty() || isPerfectSquare(current_permutation.back() + num)) {
                    freq--;
                    current_permutation.push_back(num);
                    backtrack(current_permutation);
                    current_permutation.pop_back();
                    freq++;
                }
            }
        }
    }

    int numSquarefulPerms(std::vector<int>& A) {
        n_len = A.size();
        for (int x : A) {
            nums_map[x]++;
        }

        std::vector<int> current_permutation;
        backtrack(current_permutation);

        return count;
    }
};