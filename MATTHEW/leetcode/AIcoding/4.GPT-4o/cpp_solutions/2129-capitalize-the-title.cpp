class Solution {
public:
    string capitalizeTitle(string title) {
        istringstream stream(title);
        string word, result;
        while (stream >> word) {
            if (word.size() > 2) {
                word[0] = toupper(word[0]);
            } else {
                transform(word.begin(), word.end(), word.begin(), ::tolower);
            }
            result += word + " ";
        }
        if (!result.empty()) {
            result.pop_back();
        }
        return result;
    }
};