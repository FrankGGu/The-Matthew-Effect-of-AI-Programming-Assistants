#include <iostream>
#include <vector>
#include <string>
#include <sstream>
#include <algorithm>

using namespace std;

class Solution {
public:
    string replaceWords(vector<string>& dictionary, string sentence) {
        sort(dictionary.begin(), dictionary.end());
        stringstream ss(sentence);
        string word;
        string result = "";
        while (ss >> word) {
            string replacement = "";
            for (const string& root : dictionary) {
                if (word.rfind(root, 0) == 0) {
                    replacement = root;
                    break;
                }
            }
            if (replacement == "") {
                result += word + " ";
            } else {
                result += replacement + " ";
            }
        }
        result.pop_back();
        return result;
    }
};