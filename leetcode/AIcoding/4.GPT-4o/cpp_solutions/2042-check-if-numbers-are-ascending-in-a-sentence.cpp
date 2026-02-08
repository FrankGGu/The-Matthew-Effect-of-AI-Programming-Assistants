class Solution {
public:
    bool areNumbersAscending(string s) {
        istringstream iss(s);
        string word;
        int prev = 0;

        while (iss >> word) {
            if (isdigit(word[0])) {
                int num = stoi(word);
                if (num <= prev) return false;
                prev = num;
            }
        }
        return true;
    }
};