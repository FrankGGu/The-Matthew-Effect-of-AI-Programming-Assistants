#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string decodeCiphertext(string encodedText, int rows) {
        int n = encodedText.length();
        int cols = n / rows;
        string decodedText = "";
        for (int i = 0; i < cols; ++i) {
            int row = 0;
            int col = i;
            while (row < rows && col < cols) {
                decodedText += encodedText[row * cols + col];
                row++;
                col++;
            }
        }
        while (!decodedText.empty() && decodedText.back() == ' ') {
            decodedText.pop_back();
        }
        return decodedText;
    }
};