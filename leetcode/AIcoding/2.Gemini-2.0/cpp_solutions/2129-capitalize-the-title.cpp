#include <string>
#include <vector>
#include <sstream>
#include <cctype>

using namespace std;

class Solution {
public:
    string capitalizeTitle(string title) {
        stringstream ss(title);
        string word;
        string result = "";

        while (ss >> word) {
            for (char &c : word) {
                c = tolower(c);
            }

            if (word.length() > 2) {
                word[0] = toupper(word[0]);
            }

            result += word + " ";
        }

        if (!result.empty()) {
            result.pop_back();
        }

        return result;
    }
};