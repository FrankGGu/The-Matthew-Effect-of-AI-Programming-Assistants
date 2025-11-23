class Solution {
public:
    vector<string> basicCalculatorIV(string expression, vector<string>& evalvars, vector<int>& evalints) {
        unordered_map<string, int> eval;
        for (int i = 0; i < evalvars.size(); ++i) {
            eval[evalvars[i]] = evalints[i];
        }
        auto res = helper(expression, eval);
        vector<string> ans;
        for (auto &item : res) {
            if (item.second == 0) continue;
            ans.push_back(to_string(item.second));
            for (auto &p : item.first) {
                ans.back() += "*" + p;
            }
        }
        return ans;
    }

private:
    struct cmp {
        bool operator()(const vector<string>& a, const vector<string>& b) const {
            if (a.size() != b.size()) return a.size() > b.size();
            for (int i = 0; i < a.size(); ++i) {
                if (a[i] != b[i]) return a[i] < b[i];
            }
            return false;
        }
    };

    using poly = map<vector<string>, int, cmp>;

    poly helper(string &s, unordered_map<string, int> &eval) {
        poly res;
        stack<poly> st;
        st.push({});
        int sign = 1;
        int n = s.size();
        for (int i = 0; i < n; ++i) {
            if (s[i] == ' ') continue;
            if (s[i] == '(') {
                st.push(res);
                res.clear();
                sign = 1;
            } else if (s[i] == ')') {
                poly tmp = res;
                res = st.top();
                st.pop();
                int sgn = 1;
                for (auto &item : tmp) {
                    res[item.first] += sign * item.second;
                }
                sign = 1;
            } else if (s[i] == '+' || s[i] == '-') {
                sign = s[i] == '+' ? 1 : -1;
            } else if (s[i] == '*') {
                i++;
                while (i < n && s[i] == ' ') i++;
                int j = i;
                while (j < n && s[j] != ' ' && s[j] != ')' && s[j] != '+' && s[j] != '-') j++;
                poly tmp = parse(s.substr(i, j - i), eval);
                poly new_res;
                for (auto &a : res) {
                    for (auto &b : tmp) {
                        vector<string> vars = a.first;
                        vars.insert(vars.end(), b.first.begin(), b.first.end());
                        sort(vars.begin(), vars.end());
                        new_res[vars] += a.second * b.second;
                    }
                }
                res = new_res;
                i = j - 1;
            } else {
                int j = i;
                while (j < n && s[j] != ' ' && s[j] != ')' && s[j] != '+' && s[j] != '-' && s[j] != '*') j++;
                poly tmp = parse(s.substr(i, j - i), eval);
                for (auto &item : tmp) {
                    res[item.first] += sign * item.second;
                }
                i = j - 1;
            }
        }
        return res;
    }

    poly parse(string s, unordered_map<string, int> &eval) {
        poly res;
        if (eval.count(s)) {
            res[{}] = eval[s];
        } else if (isdigit(s[0])) {
            res[{}] = stoi(s);
        } else {
            res[{s}] = 1;
        }
        return res;
    }
};