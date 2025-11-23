class Solution {
public:
    string decodeCiphertext(string encodedText, int rows) {
        if (rows == 1) return encodedText;
        int n = encodedText.size();
        int cols = n / rows;
        string res;
        for (int i = 0; i < cols; ++i) {
            for (int j = 0; j < rows; ++j) {
                if (i + j < cols) {
                    int idx = j * cols + (i + j);
                    res += encodedText[idx];
                }
            }
        }
        while (!res.empty() && res.back() == ' ') {
            res.pop_back();
        }
        return res;
    }
};