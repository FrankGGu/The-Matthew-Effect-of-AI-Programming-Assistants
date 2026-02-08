class Solution {
public:
    string capitalizeTitle(string title) {
        istringstream ss(title);
        string word, result;
        while (ss >> word) {
            if (word.size() > 2) {
                word[0] = toupper(word[0]);
            } else {
                for (char &c : word) {
                    c = tolower(c);
                }
            }
            result += word + " ";
        }
        if (!result.empty()) {
            result.pop_back();
        }
        return result;
    }
};