class Solution {
public:
    string getSmallestString(int n, int k) {
        string res(n, 'a');
        k -= n;
        for (int i = n - 1; i >= 0 && k > 0; --i) {
            int add = min(k, 25);
            res[i] += add;
            k -= add;
        }
        return res;
    }
};