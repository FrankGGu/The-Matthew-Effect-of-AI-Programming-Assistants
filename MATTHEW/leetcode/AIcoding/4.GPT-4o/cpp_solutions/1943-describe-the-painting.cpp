class Solution {
public:
    string describePainting(int n) {
        if (n == 1) return "1 black";
        string result = "1 black";
        for (int i = 2; i <= n; ++i) {
            result = to_string(i) + " " + (i % 2 == 0 ? "white" : "black") + ", " + result;
        }
        return result.substr(0, result.size() - 2);
    }
};