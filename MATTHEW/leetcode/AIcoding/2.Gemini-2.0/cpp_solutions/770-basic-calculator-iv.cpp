#include <string>
#include <vector>
#include <sstream>
#include <map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> basicCalculatorIV(string expression, vector<string>& evalvars, vector<int>& evalints) {
        map<string, int> evalmap;
        for (int i = 0; i < evalvars.size(); ++i) {
            evalmap[evalvars[i]] = evalints[i];
        }

        vector<string> tokens = tokenize(expression);
        Poly result = evaluate(tokens, evalmap);

        sort(result.begin(), result.end(), [](const Term& a, const Term& b) {
            if (a.vars.size() != b.vars.size()) {
                return a.vars.size() > b.vars.size();
            }
            return a.vars < b.vars;
        });

        vector<string> ans;
        for (const auto& term : result) {
            if (term.coeff != 0) {
                string s = to_string(term.coeff);
                for (const string& var : term.vars) {
                    s += " *" + var;
                }
                ans.push_back(s);
            }
        }
        return ans;
    }

private:
    struct Term {
        int coeff;
        vector<string> vars;

        Term(int c = 0) : coeff(c) {}
        void addVar(const string& var) {
            vars.push_back(var);
            sort(vars.begin(), vars.end());
        }
    };

    using Poly = vector<Term>;

    vector<string> tokenize(const string& expression) {
        vector<string> tokens;
        stringstream ss(expression);
        string token;
        while (ss >> token) {
            if (token == "+" || token == "-" || token == "*" || token == "(" || token == ")") {
                tokens.push_back(token);
            } else {
                size_t pos = 0;
                while ((pos = token.find_first_of("+-*()", pos)) != string::npos) {
                    if (pos > 0) {
                        tokens.push_back(token.substr(0, pos));
                    }
                    tokens.push_back(token.substr(pos, 1));
                    token = token.substr(pos + 1);
                    pos = 0;
                }
                if (!token.empty()) {
                    tokens.push_back(token);
                }
            }
        }
        return tokens;
    }

    Poly evaluate(const vector<string>& tokens, const map<string, int>& evalmap) {
        vector<Poly> nums;
        vector<string> ops;

        for (const string& token : tokens) {
            if (token == "(") {
                ops.push_back(token);
            } else if (token == ")") {
                while (ops.back() != "(") {
                    applyOp(nums, ops);
                }
                ops.pop_back();
            } else if (token == "+" || token == "-") {
                while (!ops.empty() && (ops.back() == "*" || ops.back() == "+" || ops.back() == "-")) {
                    applyOp(nums, ops);
                }
                ops.push_back(token);
            } else if (token == "*") {
                while (!ops.empty() && ops.back() == "*") {
                    applyOp(nums, ops);
                }
                ops.push_back(token);
            } else {
                Poly poly;
                if (isdigit(token[0])) {
                    poly.push_back(Term(stoi(token)));
                } else {
                    if (evalmap.count(token)) {
                        poly.push_back(Term(evalmap.at(token)));
                    } else {
                        Term term;
                        term.coeff = 1;
                        term.addVar(token);
                        poly.push_back(term);
                    }
                }
                nums.push_back(poly);
            }
        }

        while (!ops.empty()) {
            applyOp(nums, ops);
        }

        return nums.back();
    }

    void applyOp(vector<Poly>& nums, vector<string>& ops) {
        string op = ops.back();
        ops.pop_back();
        Poly num2 = nums.back();
        nums.pop_back();
        Poly num1 = nums.back();
        nums.pop_back();
        Poly result = applyOpHelper(num1, num2, op);
        nums.push_back(result);
    }

    Poly applyOpHelper(const Poly& num1, const Poly& num2, const string& op) {
        Poly result;
        if (op == "+") {
            result = addPoly(num1, num2);
        } else if (op == "-") {
            Poly negNum2 = num2;
            for (auto& term : negNum2) {
                term.coeff = -term.coeff;
            }
            result = addPoly(num1, negNum2);
        } else if (op == "*") {
            result = multiplyPoly(num1, num2);
        }
        return result;
    }

    Poly addPoly(const Poly& num1, const Poly& num2) {
        Poly result;
        int i = 0, j = 0;
        while (i < num1.size() && j < num2.size()) {
            if (num1[i].vars < num2[j].vars) {
                result.push_back(num1[i++]);
            } else if (num1[i].vars > num2[j].vars) {
                result.push_back(num2[j++]);
            } else {
                int coeff = num1[i].coeff + num2[j].coeff;
                if (coeff != 0) {
                    Term term = num1[i];
                    term.coeff = coeff;
                    result.push_back(term);
                }
                i++;
                j++;
            }
        }
        while (i < num1.size()) {
            result.push_back(num1[i++]);
        }
        while (j < num2.size()) {
            result.push_back(num2[j++]);
        }
        return result;
    }

    Poly multiplyPoly(const Poly& num1, const Poly& num2) {
        Poly result;
        for (const auto& term1 : num1) {
            for (const auto& term2 : num2) {
                Term term;
                term.coeff = term1.coeff * term2.coeff;
                term.vars = term1.vars;
                term.vars.insert(term.vars.end(), term2.vars.begin(), term2.vars.end());
                sort(term.vars.begin(), term.vars.end());
                result.push_back(term);
            }
        }

        Poly simplifiedResult;
        sort(result.begin(), result.end(), [](const Term& a, const Term& b) {
            return a.vars < b.vars;
        });

        int i = 0;
        while (i < result.size()) {
            int j = i;
            int coeff = 0;
            while (j < result.size() && result[i].vars == result[j].vars) {
                coeff += result[j].coeff;
                j++;
            }
            if (coeff != 0) {
                Term term = result[i];
                term.coeff = coeff;
                simplifiedResult.push_back(term);
            }
            i = j;
        }

        return simplifiedResult;
    }
};