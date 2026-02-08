class Solution {
public:
    vector<int> splitIntoFibonacci(string s) {
        vector<int> res;
        function<bool(int)> backtrack = [&](int start) {
            if (start == s.size() && res.size() >= 3) {
                return true;
            }
            for (int i = start; i < s.size(); ++i) {
                if (i > start && s[start] == '0') {
                    break;
                }
                long long num = stoll(s.substr(start, i - start + 1));
                if (num > INT_MAX) {
                    break;
                }
                int size = res.size();
                if (size >= 2 && num > (long long)res[size - 1] + res[size - 2]) {
                    break;
                }
                if (size < 2 || num == (long long)res[size - 1] + res[size - 2]) {
                    res.push_back((int)num);
                    if (backtrack(i + 1)) {
                        return true;
                    }
                    res.pop_back();
                }
            }
            return false;
        };
        backtrack(0);
        return res;
    }
};