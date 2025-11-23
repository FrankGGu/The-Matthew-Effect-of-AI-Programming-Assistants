class Solution {
public:
    string getHappyString(int n, int k) {
        string result;
        int count = 0;
        generateHappyStrings(n, "", count, k, result);
        return result;
    }

    void generateHappyStrings(int n, string current, int &count, int k, string &result) {
        if (current.size() == n) {
            count++;
            if (count == k) {
                result = current;
            }
            return;
        }

        for (char c : {'a', 'b', 'c'}) {
            if (current.empty() || current.back() != c) {
                generateHappyStrings(n, current + c, count, k, result);
            }
        }
    }
};