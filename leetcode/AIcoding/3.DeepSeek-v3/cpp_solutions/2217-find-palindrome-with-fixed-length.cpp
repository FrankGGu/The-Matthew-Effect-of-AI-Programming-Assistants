class Solution {
public:
    vector<long long> kthPalindrome(vector<int>& queries, int intLength) {
        vector<long long> res;
        long long half = (intLength + 1) / 2;
        long long start = pow(10, half - 1);
        long long end = pow(10, half) - 1;
        for (int q : queries) {
            if (q > (end - start + 1)) {
                res.push_back(-1);
                continue;
            }
            string left = to_string(start + q - 1);
            string right = left.substr(0, intLength - half);
            reverse(right.begin(), right.end());
            string pal = left + right;
            res.push_back(stoll(pal));
        }
        return res;
    }
};