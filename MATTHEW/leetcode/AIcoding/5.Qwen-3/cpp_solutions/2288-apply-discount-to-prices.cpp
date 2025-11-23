#include <iostream>
#include <vector>
#include <string>
#include <sstream>

using namespace std;

class Solution {
public:
    vector<string> discountPrices(string sentence, int discount) {
        vector<string> result;
        stringstream ss(sentence);
        string word;
        while (ss >> word) {
            if (word[0] == '$' && word.size() > 1 && isdigit(word[1])) {
                bool valid = true;
                for (int i = 2; i < word.size(); ++i) {
                    if (!isdigit(word[i])) {
                        valid = false;
                        break;
                    }
                }
                if (valid) {
                    long long price = stoll(word.substr(1));
                    double discounted = price * (100.0 - discount) / 100.0;
                    stringstream s;
                    s << "$" << fixed << setprecision(2) << discounted;
                    result.push_back(s.str());
                } else {
                    result.push_back(word);
                }
            } else {
                result.push_back(word);
            }
        }
        return result;
    }
};