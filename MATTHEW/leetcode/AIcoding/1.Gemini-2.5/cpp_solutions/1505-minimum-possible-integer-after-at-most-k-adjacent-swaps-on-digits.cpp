#include <string>
#include <vector>
#include <queue>

class BIT {
    std::vector<int> tree;
    int size;
public:
    BIT(int n) : size(n), tree(n + 1, 0) {}

    void update(int original_idx, int delta) {
        original_idx++; 
        while (original_idx <= size) {
            tree[original_idx] += delta;
            original_idx += original_idx & (-original_idx);
        }
    }

    int query(int original_idx) {
        original_idx++; 
        int sum = 0;
        while (original_idx > 0) {
            sum += tree[original_idx];
            original_idx -= original_idx & (-original_idx);
        }
        return sum;
    }
};

class Solution {
public:
    std::string minInteger(std::string num, int k) {
        int n = num.length();
        std::vector<std::queue<int>> pos(10); 
        for (int i = 0; i < n; ++i) {
            pos[num[i] - '0'].push(i);
        }

        BIT bit(n); 
        std::string ans = "";
        ans.reserve(n); 

        for (int i = 0; i < n; ++i) {
            for (int d = 0; d <= 9; ++d) {
                if (!pos[d].empty()) {
                    int original_idx = pos[d].front();

                    int swaps_needed = original_idx - bit.query(original_idx - 1);

                    if (swaps_needed <= k) {
                        ans += (char)('0' + d);
                        k -= swaps_needed;
                        pos[d].pop(); 
                        bit.update(original_idx, 1); 
                        break; 
                    }
                }
            }
        }
        return ans;
    }
};