class Solution {
public:
    vector<string> addOperators(string num, int target) {
        vector<string> result;
        string path;
        backtrack(result, path, num, target, 0, 0, 0);
        return result;
    }

private:
    void backtrack(vector<string>& result, string& path, string& num, int target, int pos, long long eval, long long multed) {
        if (pos == num.size()) {
            if (eval == target) {
                result.push_back(path);
            }
            return;
        }

        for (int i = pos; i < num.size(); ++i) {
            if (i > pos && num[pos] == '0') break; 
            string curr = num.substr(pos, i - pos + 1);
            long long currNum = stoll(curr);

            if (pos == 0) {
                path = curr;
                backtrack(result, path, num, target, i + 1, currNum, currNum);
            } else {
                path += '+' + curr;
                backtrack(result, path, num, target, i + 1, eval + currNum, currNum);
                path.erase(path.size() - curr.size() - 1);

                path += '-' + curr;
                backtrack(result, path, num, target, i + 1, eval - currNum, -currNum);
                path.erase(path.size() - curr.size() - 1);

                path += '*' + curr;
                backtrack(result, path, num, target, i + 1, eval - multed + multed * currNum, multed * currNum);
                path.erase(path.size() - curr.size() - 1);
            }
        }
    }
};