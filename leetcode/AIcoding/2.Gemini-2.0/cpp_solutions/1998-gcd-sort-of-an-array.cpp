#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int find(vector<int>& parent, int i) {
        if (parent[i] == i)
            return i;
        return parent[i] = find(parent, parent[i]);
    }

    void unite(vector<int>& parent, vector<int>& rank, int x, int y) {
        x = find(parent, x);
        y = find(parent, y);
        if (x != y) {
            if (rank[x] < rank[y])
                swap(x, y);
            parent[y] = x;
            if (rank[x] == rank[y])
                rank[x]++;
        }
    }

    bool gcdSort(vector<int>& nums) {
        int n = nums.size();
        int mx = *max_element(nums.begin(), nums.end());
        vector<int> parent(mx + 1);
        vector<int> rank(mx + 1, 0);
        for (int i = 0; i <= mx; i++)
            parent[i] = i;

        for (int num : nums) {
            for (int i = 2; i * i <= num; i++) {
                if (num % i == 0) {
                    unite(parent, rank, num, i);
                    unite(parent, rank, num, num / i);
                }
            }
            if (num > 1)
                unite(parent, rank, num, 1);
        }

        vector<int> sortedNums = nums;
        sort(sortedNums.begin(), sortedNums.end());

        for (int i = 0; i < n; i++) {
            if (find(parent, nums[i]) != find(parent, sortedNums[i]))
                return false;
        }

        return true;
    }
};