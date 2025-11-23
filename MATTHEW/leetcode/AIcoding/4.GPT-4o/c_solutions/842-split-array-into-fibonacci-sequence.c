class Solution {
public:
    vector<int> splitIntoFibonacci(string S) {
        vector<int> result;
        int n = S.size();
        for (int i = 1; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                result.clear();
                if (backtrack(S, 0, i, j, result)) {
                    return result;
                }
            }
        }
        return {};
    }

    bool backtrack(const string& S, int start, int len1, int len2, vector<int>& result) {
        if (start == S.size()) {
            return result.size() >= 3;
        }
        long num1 = stol(S.substr(start, len1));
        long num2 = stol(S.substr(start + len1, len2));
        if (to_string(num1).size() != len1 || to_string(num2).size() != len2) return false;
        result.push_back(num1);
        result.push_back(num2);
        long sum = num1 + num2;
        int pos = start + len1 + len2;
        while (pos < S.size()) {
            string sumStr = to_string(sum);
            if (S.substr(pos, sumStr.size()) != sumStr) {
                result.pop_back();
                result.pop_back();
                return false;
            }
            result.push_back(sum);
            pos += sumStr.size();
            num1 = num2;
            num2 = sum;
            sum = num1 + num2;
        }
        return start + len1 + len2 == S.size();
    }
};