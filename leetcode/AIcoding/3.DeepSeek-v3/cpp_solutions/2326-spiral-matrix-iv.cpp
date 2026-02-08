class Solution {
public:
    vector<vector<int>> spiralMatrix(int m, int n, ListNode* head) {
        vector<vector<int>> matrix(m, vector<int>(n, -1));
        int top = 0, bottom = m - 1, left = 0, right = n - 1;
        ListNode* current = head;

        while (current != nullptr && top <= bottom && left <= right) {
            for (int i = left; i <= right && current != nullptr; ++i) {
                matrix[top][i] = current->val;
                current = current->next;
            }
            top++;

            for (int i = top; i <= bottom && current != nullptr; ++i) {
                matrix[i][right] = current->val;
                current = current->next;
            }
            right--;

            if (top <= bottom) {
                for (int i = right; i >= left && current != nullptr; --i) {
                    matrix[bottom][i] = current->val;
                    current = current->next;
                }
                bottom--;
            }

            if (left <= right) {
                for (int i = bottom; i >= top && current != nullptr; --i) {
                    matrix[i][left] = current->val;
                    current = current->next;
                }
                left++;
            }
        }

        return matrix;
    }
};