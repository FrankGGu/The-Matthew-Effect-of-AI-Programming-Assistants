class Solution {
public:
    string decodeCiphertext(string encodedText, int rows) {
        int n = encodedText.size();
        if (rows == 0 || n == 0) return "";
        int cols = n / rows;
        string result;

        for (int col = 0; col < cols; col++) {
            for (int row = 0; row + col < rows && row + col * rows < n; row++) {
                result += encodedText[row + col * rows];
            }
        }

        while (!result.empty() && result.back() == ' ') {
            result.pop_back();
        }

        return result;
    }
};