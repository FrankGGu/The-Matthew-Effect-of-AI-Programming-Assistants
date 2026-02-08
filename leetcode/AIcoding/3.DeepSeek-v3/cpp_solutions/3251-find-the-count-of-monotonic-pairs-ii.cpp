#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long countMonotonicPairs(vector<int>& nums) {
        int n = nums.size();
        if (n < 2) return 0;

        vector<int> sorted_nums = nums;
        sort(sorted_nums.begin(), sorted_nums.end());

        vector<int> fenwick(n + 1, 0);
        long long res = 0;

        for (int i = n - 1; i >= 0; --i) {
            int x = lower_bound(sorted_nums.begin(), sorted_nums.end(), nums[i]) - sorted_nums.begin() + 1;
            int y = upper_bound(sorted_nums.begin(), sorted_nums.end(), nums[i] / 2) - sorted_nums.begin();

            res += query(fenwick, y);
            update(fenwick, x);
        }

        return res;
    }

private:
    int query(vector<int>& fenwick, int index) {
        int sum = 0;
        while (index > 0) {
            sum += fenwick[index];
            index -= index & -index;
        }
        return sum;
    }

    void update(vector<int>& fenwick, int index) {
        while (index < fenwick.size()) {
            fenwick[index] += 1;
            index += index & -index;
        }
    }
};