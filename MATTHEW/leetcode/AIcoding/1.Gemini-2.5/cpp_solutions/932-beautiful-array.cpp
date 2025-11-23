#include <vector>
#include <unordered_map>

class Solution {
public:
    std::unordered_map<int, std::vector<int>> memo;

    std::vector<int> beautifulArray(int n) {
        if (n == 1) {
            return {1};
        }
        if (memo.count(n)) {
            return memo[n];
        }

        std::vector<int> res;

        // Generate odd numbers from a beautiful array of size (n + 1) / 2
        // For each x in beautifulArray((n + 1) / 2), add 2*x - 1 to res.
        for (int x : beautifulArray((n + 1) / 2)) {
            res.push_back(2 * x - 1);
        }

        // Generate even numbers from a beautiful array of size n / 2
        // For each x in beautifulArray(n / 2), add 2*x to res.
        for (int x : beautifulArray(n / 2)) {
            res.push_back(2 * x);
        }

        return memo[n] = res;
    }
};