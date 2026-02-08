#include <vector>
#include <algorithm>
#include <numeric>

class FenwickTree {
private:
    std::vector<int> tree;
    int size;

public:
    FenwickTree(int s) : size(s), tree(s + 1, 0) {}

    void update(int idx, int delta) {
        for (; idx <= size; idx += idx & -idx) {
            tree[idx] += delta;
        }
    }

    int query(int idx) {
        int sum = 0;
        for (; idx > 0; idx -= idx & -idx) {
            sum += tree[idx];
        }
        return sum;
    }
};

class Solution {
public:
    std::vector<int> distributeElements(std::vector<int>& nums) {
        int n = nums.size();

        std::vector<int> sorted_unique_nums = nums;
        std::sort(sorted_unique_nums.begin(), sorted_unique_nums.end());
        sorted_unique_nums.erase(std::unique(sorted_unique_nums.begin(), sorted_unique_nums.end()), sorted_unique_nums.end());

        int max_rank = sorted_unique_nums.size();

        auto get_rank = [&](int val) {
            return std::lower_bound(sorted_unique_nums.begin(), sorted_unique_nums.end(), val) - sorted_unique_nums.begin() + 1;
        };

        std::vector<int> arr1;
        std::vector<int> arr2;

        arr1.push_back(nums[0]);
        arr2.push_back(nums[1]);

        FenwickTree bit1(max_rank);
        FenwickTree bit2(max_rank);

        bit1.update(get_rank(nums[0]), 1);
        bit2.update(get_rank(nums[1]), 1);

        for (int i = 2; i < n; ++i) {
            int current_num = nums[i];
            int current_rank = get_rank(current_num);

            int count1 = bit1.query(max_rank) - bit1.query(current_rank);
            int count2 = bit2.query(max_rank) - bit2.query(current_rank);

            if (count1 > count2) {
                arr1.push_back(current_num);
                bit1.update(current_rank, 1);
            } else if (count2 > count1) {
                arr2.push_back(current_num);
                bit2.update(current_rank, 1);
            } else { 
                if (arr1.size() <= arr2.size()) {
                    arr1.push_back(current_num);
                    bit1.update(current_rank, 1);
                } else {
                    arr2.push_back(current_num);
                    bit2.update(current_rank, 1);
                }
            }
        }

        arr1.insert(arr1.end(), arr2.begin(), arr2.end());
        return arr1;
    }
};