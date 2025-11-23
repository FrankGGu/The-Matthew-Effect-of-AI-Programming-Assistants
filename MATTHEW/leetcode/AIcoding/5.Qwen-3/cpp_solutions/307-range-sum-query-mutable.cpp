#include <iostream>
#include <vector>

using namespace std;

class Solution {
private:
    vector<int> nums;
    vector<int> tree;
    int size;

    void buildTree(int node, int start, int end) {
        if (start == end) {
            tree[node] = nums[start];
        } else {
            int mid = (start + end) / 2;
            buildTree(2 * node, start, mid);
            buildTree(2 * node + 1, mid + 1, end);
            tree[node] = tree[2 * node] + tree[2 * node + 1];
        }
    }

    void updateTree(int node, int start, int end, int idx, int value) {
        if (start == end) {
            tree[node] = value;
        } else {
            int mid = (start + end) / 2;
            if (idx <= mid) {
                updateTree(2 * node, start, mid, idx, value);
            } else {
                updateTree(2 * node + 1, mid + 1, end, idx, value);
            }
            tree[node] = tree[2 * node] + tree[2 * node + 1];
        }
    }

    int queryTree(int node, int start, int end, int l, int r) {
        if (r < start || end < l) {
            return 0;
        }
        if (l <= start && end <= r) {
            return tree[node];
        }
        int mid = (start + end) / 2;
        return queryTree(2 * node, start, mid, l, r) + queryTree(2 * node + 1, mid + 1, end, l, r);
    }

public:
    Solution(vector<int>& nums) {
        this->nums = nums;
        size = nums.size();
        tree.resize(4 * size);
        buildTree(1, 0, size - 1);
    }

    void update(int index, int val) {
        updateTree(1, 0, size - 1, index, val);
    }

    int sumRange(int left, int right) {
        return queryTree(1, 0, size - 1, left, right);
    }
};