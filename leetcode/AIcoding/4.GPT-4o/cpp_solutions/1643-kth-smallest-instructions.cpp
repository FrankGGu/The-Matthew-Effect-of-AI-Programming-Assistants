class Solution {
public:
    string kthSmallestPath(vector<int>& destination, int k) {
        int m = destination[0], n = destination[1];
        string res;
        int total = m + n;

        for (int i = 0; i < total; ++i) {
            int choose = comb(total - 1, n - 1);
            if (k <= choose) {
                res += 'H';
                m--;
            } else {
                res += 'V';
                n--;
                k -= choose;
            }
            total--;
        }
        return res;
    }

private:
    int comb(int n, int k) {
        if (k > n) return 0;
        if (k == 0 || k == n) return 1;
        long long res = 1;
        for (int i = 1; i <= k; ++i) {
            res = res * (n - i + 1) / i;
        }
        return res;
    }
};