#include <vector>
#include <algorithm>
using namespace std;

class FenwickTree {
private:
    vector<int> tree;
public:
    FenwickTree(int size) : tree(size + 1, 0) {}

    void update(int index, int delta) {
        for (; index < tree.size(); index += index & -index) {
            tree[index] += delta;
        }
    }

    int query(int index) {
        int sum = 0;
        for (; index > 0; index -= index & -index) {
            sum += tree[index];
        }
        return sum;
    }
};

class Solution {
public:
    long long goodTriplets(vector<int>& nums1, vector<int>& nums2) {
        int n = nums1.size();
        vector<int> pos(n);
        for (int i = 0; i < n; ++i) {
            pos[nums2[i]] = i;
        }
        vector<int> a(n);
        for (int i = 0; i < n; ++i) {
            a[i] = pos[nums1[i]] + 1;
        }

        FenwickTree left(n), right(n);
        for (int num : a) {
            right.update(num, 1);
        }

        long long res = 0;
        for (int i = 0; i < n; ++i) {
            int num = a[i];
            right.update(num, -1);
            long long left_count = left.query(num - 1);
            long long right_count = right.query(n) - right.query(num);
            res += left_count * right_count;
            left.update(num, 1);
        }
        return res;
    }
};