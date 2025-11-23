class Solution {
public:
    std::vector<std::vector<int>> spiralMatrix(int m, int n, ListNode* head) {
        std::vector<std::vector<int>> matrix(m, std::vector<int>(n, -1));

        int rowStart = 0;
        int rowEnd = m - 1;
        int colStart = 0;
        int colEnd = n - 1;

        while (head != nullptr && rowStart <= rowEnd && colStart <= colEnd) {
            // Traverse right
            for (int c = colStart; c <= colEnd; ++c) {
                if (head == nullptr) break;
                matrix[rowStart][c] = head->val;
                head = head->next;
            }
            rowStart++;
            if (head == nullptr || rowStart > rowEnd) break;

            // Traverse down
            for (int r = rowStart; r <= rowEnd; ++r) {
                if (head == nullptr) break;
                matrix[r][colEnd] = head->val;
                head = head->next;
            }
            colEnd--;
            if (head == nullptr || colStart > colEnd) break;

            // Traverse left
            if (rowStart <= rowEnd) {
                for (int c = colEnd; c >= colStart; --c) {
                    if (head == nullptr) break;
                    matrix[rowEnd][c] = head->val;
                    head = head->next;
                }
            }
            rowEnd--;
            if (head == nullptr || rowStart > rowEnd) break;

            // Traverse up
            if (colStart <= colEnd) {
                for (int r = rowEnd; r >= rowStart; --r) {
                    if (head == nullptr) break;
                    matrix[r][colStart] = head->val;
                    head = head->next;
                }
            }
            colStart++;
        }

        return matrix;
    }
};