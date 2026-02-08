class Solution {
public:
    vector<string> generateBinaryStrings(int n) {
        vector<string> result;
        string current;
        generate(result, current, n, 0);
        return result;
    }

    void generate(vector<string>& result, string& current, int n, int count) {
        if (current.size() == n) {
            result.push_back(current);
            return;
        }

        if (count < 2) {
            current.push_back('0');
            generate(result, current, n, count + 1);
            current.pop_back();
        }

        current.push_back('1');
        generate(result, current, n, 0);
        current.pop_back();
    }
};