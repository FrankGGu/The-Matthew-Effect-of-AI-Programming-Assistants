class Solution {
public:
    int numDifferentIntegers(string word) {
        set<string> uniqueIntegers;
        string currentNumber;
        for (char c : word) {
            if (isdigit(c)) {
                currentNumber += c;
            } else {
                if (!currentNumber.empty()) {
                    uniqueIntegers.insert(removeLeadingZeros(currentNumber));
                    currentNumber.clear();
                }
            }
        }
        if (!currentNumber.empty()) {
            uniqueIntegers.insert(removeLeadingZeros(currentNumber));
        }
        return uniqueIntegers.size();
    }

private:
    string removeLeadingZeros(string s) {
        while (s.size() > 1 && s[0] == '0') {
            s.erase(s.begin());
        }
        return s.empty() ? "0" : s;
    }
};