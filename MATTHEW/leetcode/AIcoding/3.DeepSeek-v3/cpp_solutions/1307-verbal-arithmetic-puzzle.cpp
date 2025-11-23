class Solution {
public:
    bool isSolvable(vector<string>& words, string result) {
        unordered_map<char, int> charToDigit;
        unordered_set<char> leadingChars;
        vector<char> uniqueChars;
        string allChars;

        for (string& word : words) {
            if (word.size() > 1) leadingChars.insert(word[0]);
            for (char c : word) allChars += c;
        }
        if (result.size() > 1) leadingChars.insert(result[0]);
        for (char c : result) allChars += c;

        unordered_set<char> seen;
        for (int i = allChars.size() - 1; i >= 0; --i) {
            if (seen.find(allChars[i]) == seen.end()) {
                seen.insert(allChars[i]);
                uniqueChars.push_back(allChars[i]);
            }
        }

        vector<bool> used(10, false);
        return backtrack(0, 0, uniqueChars, charToDigit, leadingChars, used, words, result);
    }

private:
    bool backtrack(int pos, int sum, vector<char>& uniqueChars, unordered_map<char, int>& charToDigit, 
                   unordered_set<char>& leadingChars, vector<bool>& used, vector<string>& words, string& result) {
        if (pos == uniqueChars.size()) {
            return sum == 0;
        }

        char c = uniqueChars[pos];
        int start = (leadingChars.find(c) != leadingChars.end()) ? 1 : 0;
        for (int d = start; d <= 9; ++d) {
            if (!used[d]) {
                used[d] = true;
                charToDigit[c] = d;
                int newSum = computeSum(words, result, charToDigit, uniqueChars, pos, sum);
                if (backtrack(pos + 1, newSum, uniqueChars, charToDigit, leadingChars, used, words, result)) {
                    return true;
                }
                used[d] = false;
            }
        }
        return false;
    }

    int computeSum(vector<string>& words, string& result, unordered_map<char, int>& charToDigit, 
                   vector<char>& uniqueChars, int pos, int sum) {
        for (string& word : words) {
            if (word.size() > pos) {
                char c = word[word.size() - 1 - pos];
                if (charToDigit.find(c) != charToDigit.end()) {
                    sum += charToDigit[c];
                }
            }
        }

        char resChar = result.size() > pos ? result[result.size() - 1 - pos] : '\0';
        if (resChar != '\0' && charToDigit.find(resChar) != charToDigit.end()) {
            sum -= charToDigit[resChar];
        }

        return sum / 10;
    }
};