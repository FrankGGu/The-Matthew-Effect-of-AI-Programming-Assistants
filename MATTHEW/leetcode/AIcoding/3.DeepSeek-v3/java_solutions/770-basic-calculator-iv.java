import java.util.*;

class Solution {
    private Map<String, Integer> evalVars = new HashMap<>();

    public List<String> basicCalculatorIV(String expression, String[] evalvars, int[] evalints) {
        for (int i = 0; i < evalvars.length; ++i) {
            evalVars.put(evalvars[i], evalints[i]);
        }
        Expression res = parse(expression);
        List<String> ans = new ArrayList<>();
        for (Term term : res.terms) {
            if (term.coeff == 0) continue;
            ans.add(term.toString());
        }
        return ans;
    }

    private Expression parse(String expr) {
        List<Expression> bucket = new ArrayList<>();
        List<Character> ops = new ArrayList<>();
        int i = 0;
        while (i < expr.length()) {
            if (expr.charAt(i) == ' ') {
                ++i;
                continue;
            }
            if (expr.charAt(i) == '(') {
                int j = i + 1;
                int bal = 1;
                while (j < expr.length() && bal > 0) {
                    if (expr.charAt(j) == '(') ++bal;
                    if (expr.charAt(j) == ')') --bal;
                    ++j;
                }
                Expression sub = parse(expr.substring(i + 1, j - 1));
                bucket.add(sub);
                i = j;
            } else if (Character.isLetterOrDigit(expr.charAt(i))) {
                int j = i;
                while (j < expr.length() && (Character.isLetterOrDigit(expr.charAt(j)))) {
                    ++j;
                }
                String token = expr.substring(i, j);
                Expression e;
                if (Character.isDigit(token.charAt(0))) {
                    e = new Expression(Integer.parseInt(token));
                } else if (evalVars.containsKey(token)) {
                    e = new Expression(evalVars.get(token));
                } else {
                    e = new Expression(1);
                    e.terms.get(0).vars.add(token);
                }
                bucket.add(e);
                i = j;
            } else {
                ops.add(expr.charAt(i));
                ++i;
            }
        }

        for (int k = 0; k < ops.size(); ++k) {
            if (ops.get(k) == '*') {
                bucket.set(k + 1, multiply(bucket.get(k), bucket.get(k + 1)));
                bucket.set(k, new Expression(0));
                ops.set(k, '+');
            }
        }

        Expression res = new Expression(0);
        for (Expression e : bucket) {
            res = add(res, e);
        }
        return res;
    }

    private Expression add(Expression a, Expression b) {
        Expression res = new Expression(0);
        res.terms.addAll(a.terms);
        res.terms.addAll(b.terms);
        res.merge();
        return res;
    }

    private Expression multiply(Expression a, Expression b) {
        Expression res = new Expression(0);
        for (Term t1 : a.terms) {
            for (Term t2 : b.terms) {
                Term product = new Term(t1.coeff * t2.coeff);
                product.vars.addAll(t1.vars);
                product.vars.addAll(t2.vars);
                Collections.sort(product.vars);
                res.terms.add(product);
            }
        }
        res.merge();
        return res;
    }

    static class Expression {
        List<Term> terms;

        Expression(int coeff) {
            terms = new ArrayList<>();
            terms.add(new Term(coeff));
        }

        void merge() {
            Collections.sort(terms);
            List<Term> merged = new ArrayList<>();
            for (Term term : terms) {
                if (merged.isEmpty()) {
                    merged.add(term);
                } else {
                    Term last = merged.get(merged.size() - 1);
                    if (last.compareTo(term) == 0) {
                        last.coeff += term.coeff;
                    } else {
                        merged.add(term);
                    }
                }
            }
            terms = merged;
        }
    }

    static class Term implements Comparable<Term> {
        int coeff;
        List<String> vars;

        Term(int coeff) {
            this.coeff = coeff;
            this.vars = new ArrayList<>();
        }

        @Override
        public int compareTo(Term other) {
            if (this.vars.size() != other.vars.size()) {
                return other.vars.size() - this.vars.size();
            }
            for (int i = 0; i < this.vars.size(); ++i) {
                int cmp = this.vars.get(i).compareTo(other.vars.get(i));
                if (cmp != 0) return cmp;
            }
            return 0;
        }

        @Override
        public String toString() {
            StringBuilder sb = new StringBuilder();
            sb.append(coeff);
            for (String var : vars) {
                sb.append('*').append(var);
            }
            return sb.toString();
        }
    }
}