class Solution {
public:
    string countOfAtoms(string formula) {
        stack<map<string, int>> st;
        st.push({});
        int i = 0, n = formula.size();

        while (i < n) {
            if (formula[i] == '(') {
                st.push({});
                i++;
            } else if (formula[i] == ')') {
                auto top = st.top();
                st.pop();
                i++;
                int num = 0;
                while (i < n && isdigit(formula[i])) {
                    num = num * 10 + (formula[i] - '0');
                    i++;
                }
                num = num == 0 ? 1 : num;
                for (auto& [atom, cnt] : top) {
                    st.top()[atom] += cnt * num;
                }
            } else {
                string atom;
                atom += formula[i++];
                while (i < n && islower(formula[i])) {
                    atom += formula[i++];
                }
                int num = 0;
                while (i < n && isdigit(formula[i])) {
                    num = num * 10 + (formula[i] - '0');
                    i++;
                }
                num = num == 0 ? 1 : num;
                st.top()[atom] += num;
            }
        }

        auto& count = st.top();
        vector<pair<string, int>> atoms(count.begin(), count.end());
        sort(atoms.begin(), atoms.end());

        string res;
        for (auto& [atom, cnt] : atoms) {
            res += atom;
            if (cnt > 1) {
                res += to_string(cnt);
            }
        }
        return res;
    }
};