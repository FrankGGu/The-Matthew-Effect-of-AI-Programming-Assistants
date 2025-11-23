class Solution {
public:
    string truncateSentence(string s, int k) {
        istringstream iss(s);
        string word;
        string result;
        for (int i = 0; i < k && iss >> word; ++i) {
            result += word + (i < k - 1 ? " " : "");
        }
        return result;
    }
};