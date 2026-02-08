#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    bool canDivide(int x, int y) {
        return std::gcd(x, y) > 1;
    }

    int find(int x, std::vector<int>& parent) {
        if (parent[x] != x) {
            parent[x] = find(parent[x], parent);
        }
        return parent[x];
    }

    void unite(int x, int y, std::vector<int>& parent) {
        int rootX = find(x, parent);
        int rootY = find(y, parent);
        if (rootX != rootY) {
            parent[rootY] = rootX;
        }
    }

    bool gcdSortArray(std::vector<int>& nums) {
        int maxNum = *std::max_element(nums.begin(), nums.end());
        std::vector<int> parent(maxNum + 1);
        for (int i = 0; i <= maxNum; ++i) {
            parent[i] = i;
        }

        for (int num : nums) {
            for (int i = 2; i * i <= num; ++i) {
                if (num % i == 0) {
                    unite(num, i, parent);
                    unite(num, num / i, parent);
                }
            }
        }

        for (int i = 0; i < nums.size(); ++i) {
            for (int j = i + 1; j < nums.size(); ++j) {
                if (canDivide(nums[i], nums[j]) && find(nums[i], parent) != find(nums[j], parent)) {
                    return false;
                }
            }
        }

        return true;
    }
};