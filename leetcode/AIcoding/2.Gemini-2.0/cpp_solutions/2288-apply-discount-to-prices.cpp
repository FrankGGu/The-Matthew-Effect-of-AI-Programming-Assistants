#include <sstream>
#include <vector>
#include <iomanip>

using namespace std;

class Solution {
public:
    string applyDiscount(string sentence, double discount) {
        stringstream ss(sentence);
        string word;
        vector<string> words;

        while (ss >> word) {
            words.push_back(word);
        }

        for (string& word : words) {
            if (word.length() > 1 && word[0] == '$') {
                bool valid = true;
                for (int i = 1; i < word.length(); ++i) {
                    if (!isdigit(word[i])) {
                        valid = false;
                        break;
                    }
                }
                if (valid) {
                    double price = stod(word.substr(1));
                    double discounted_price = price * (1 - discount / 100.0);
                    stringstream stream;
                    stream << fixed << setprecision(2) << discounted_price;
                    word = "$" + stream.str();
                }
            }
        }

        string result = "";
        for (int i = 0; i < words.size(); ++i) {
            result += words[i];
            if (i < words.size() - 1) {
                result += " ";
            }
        }

        return result;
    }
};