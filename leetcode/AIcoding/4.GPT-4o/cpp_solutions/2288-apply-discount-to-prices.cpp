class Solution {
public:
    string discountPrices(string sentence, int discount) {
        istringstream iss(sentence);
        string word, result;
        while (iss >> word) {
            if (word.size() > 1 && word[0] == '$') {
                long long price = stoll(word.substr(1));
                price = price * (100 - discount) / 100;
                result += '$' + to_string(price) + ' ';
            } else {
                result += word + ' ';
            }
        }
        if (!result.empty()) result.pop_back();
        return result;
    }
};