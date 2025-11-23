class Solution {
public:
    vector<vector<int>> spiralMatrix(int m, int n, ListNode* head) {
        vector<vector<int>> matrix(m, vector<int>(n, -1));
        int rowStart = 0, rowEnd = m - 1;
        int colStart = 0, colEnd = n - 1;

        while (head != nullptr && rowStart <= rowEnd && colStart <= colEnd) {
            for (int i = colStart; i <= colEnd && head != nullptr; ++i) {
                matrix[rowStart][i] = head->val;
                head = head->next;
            }
            rowStart++;

            for (int i = rowStart; i <= rowEnd && head != nullptr; ++i) {
                matrix[i][colEnd] = head->val;
                head = head->next;
            }
            colEnd--;

            for (int i = colEnd; i >= colStart && head != nullptr; --i) {
                matrix[rowEnd][i] = head->val;
                head = head->next;
            }
            rowEnd--;

            for (int i = rowEnd; i >= rowStart && head != nullptr; --i) {
                matrix[i][colStart] = head->val;
                head = head->next;
            }
            colStart++;
        }

        return matrix;
    }
};