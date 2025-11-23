#include <string>
#include <map>

using namespace std;

class Solution {
public:
    string countOfAtoms(string formula) {
        int n = formula.length();
        int i = 0;
        map<string, int> counts = parse(formula, i);
        string res = "";
        for (auto const& [element, count] : counts) {
            res += element;
            if (count > 1) {
                res += to_string(count);
            }
        }
        return res;
    }

private:
    map<string, int> parse(string& formula, int& i) {
        map<string, int> counts;
        while (i < formula.length() && formula[i] != ')') {
            if (formula[i] == '(') {
                i++;
                map<string, int> subCounts = parse(formula, i);
                i++;
                int num = parseNumber(formula, i);
                for (auto const& [element, count] : subCounts) {
                    counts[element] += count * num;
                }
            } else {
                string element = parseElement(formula, i);
                int num = parseNumber(formula, i);
                counts[element] += num;
            }
        }
        return counts;
    }

    string parseElement(string& formula, int& i) {
        string element = "";
        element += formula[i++];
        while (i < formula.length() && islower(formula[i])) {
            element += formula[i++];
        }
        return element;
    }

    int parseNumber(string& formula, int& i) {
        int num = 0;
        while (i < formula.length() && isdigit(formula[i])) {
            num = num * 10 + (formula[i] - '0');
            i++;
        }
        return num == 0 ? 1 : num;
    }
};