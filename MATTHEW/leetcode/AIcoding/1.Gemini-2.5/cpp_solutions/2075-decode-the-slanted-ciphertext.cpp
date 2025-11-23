#include <string>
#include <vector>
#include <numeric>

class Solution {
public:
    std::string decodeCiphertext(std::string encodedText, int rows) {
        if (encodedText.empty()) {
            return "";
        }

        int len = encodedText.length();
        int cols = len / rows;

        std::vector<std::vector<char>> grid(rows, std::vector<char>(cols));

        int k = 0; // Index for encodedText

        // Fill the grid by simulating the encoding process in reverse.
        // The encoding process reads characters diagonally.
        // The problem description states: "The first slanted sequence starts at cell (0, 0), then (1, 1), (2, 2), and so on.
        // The second slanted sequence starts at cell (0, 1), then (1, 2), (2, 3), and so on.
        // This continues until all cells in the first row are used as starting points for a slanted sequence."
        //
        // This description only explicitly mentions diagonals starting from the first row (r=0).
        // However, for `encodedText.length()` to be equal to `rows * cols` (which is implied by the problem
        // statement that `cols = encodedText.length() / rows` and the fact that all grid cells must be filled),
        // the diagonal traversal must cover all cells.
        // A common way to achieve this in diagonal traversal is to start diagonals from all cells in the first row
        // AND all cells in the first column (excluding (0,0) which is covered by the first row starts).

        // Part 1: Diagonals starting from the first row (r_start = 0, c_start = j_start)
        for (int j_start = 0; j_start < cols; ++j_start) {
            for (int i = 0; i < rows; ++i) { // 'i' is the offset along the diagonal
                int r = i;
                int c = j_start + i;
                if (r < rows && c < cols) { // Check bounds
                    if (k < len) {
                        grid[r][c] = encodedText[k++];
                    } else {
                        break; 
                    }
                } else {
                    break; // Diagonal sequence has gone out of bounds
                }
            }
        }

        // Part 2: Diagonals starting from the first column (c_start = 0), for r_start > 0
        // This part is necessary to cover all cells and consume all of encodedText if k < len after Part 1.
        for (int r_start = 1; r_start < rows; ++r_start) {
            for (int i = 0; i < cols; ++i) { // 'i' is the offset along the diagonal
                int r = r_start + i;
                int c = i;
                if (r < rows && c < cols) { // Check bounds
                    if (k < len) {
                        grid[r][c] = encodedText[k++];
                    } else {
                        break;
                    }
                } else {
                    break; // Diagonal sequence has gone out of bounds
                }
            }
        }

        // Reconstruct the original text by reading the grid row by row
        std::string originalText = "";
        for (int r = 0; r < rows; ++r) {
            for (int c = 0; c < cols; ++c) {
                originalText += grid[r][c];
            }
        }

        // Remove trailing spaces from the reconstructed original text
        while (!originalText.empty() && originalText.back() == ' ') {
            originalText.pop_back();
        }

        return originalText;
    }
};