class Solution {
public:
    vector<int> splitIntoFibonacci(string num) {
        vector<int> res;
        backtrack(num, res, 0);
        return res;
    }

    bool backtrack(const string& num, vector<int>& res, int index) {
        if (index == num.size() && res.size() >= 3) {
            return true;
        }
        for (int i = index; i < num.size(); ++i) {
            if (num[index] == '0' && i > index) {
                break;
            }
            long long curr = stoll(num.substr(index, i - index + 1));
            if (curr > INT_MAX) {
                break;
            }
            if (res.size() >= 2) {
                long long sum = (long long)res[res.size() - 1] + res[res.size() - 2];
                if (curr < sum) {
                    continue;
                } else if (curr > sum) {
                    break;
                }
            }
            res.push_back(curr);
            if (backtrack(num, res, i + 1)) {
                return true;
            }
            res.pop_back();
        }
        return false;
    }
};