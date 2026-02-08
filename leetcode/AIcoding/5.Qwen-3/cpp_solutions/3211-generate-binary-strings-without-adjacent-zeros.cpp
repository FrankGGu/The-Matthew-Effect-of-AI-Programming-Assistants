#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> validStrings(int n) {
        vector<string> result;
        generate(result, "", n);
        return result;
    }

private:
    void generate(vector<string>& result, string current, int n) {
        if (current.length() == n) {
            result.push_back(current);
            return;
        }
        if (current.empty() || current.back() != '0') {
            generate(result, current + '0', n);
        }
        generate(result, current + '1', n);
    }
};