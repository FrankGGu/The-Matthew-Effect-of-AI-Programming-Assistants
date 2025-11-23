public class Solution {
    public ListNode spiralMatrix(int m, int n, int[][] matrix) {
        ListNode head = new ListNode(0);
        ListNode current = head;
        int top = 0, bottom = m - 1, left = 0, right = n - 1;

        while (top <= bottom && left <= right) {
            for (int i = left; i <= right; i++) {
                current.next = new ListNode(matrix[top][i]);
                current = current.next;
            }
            top++;

            for (int i = top; i <= bottom; i++) {
                current.next = new ListNode(matrix[i][right]);
                current = current.next;
            }
            right--;

            for (int i = right; i >= left && top <= bottom; i--) {
                current.next = new ListNode(matrix[bottom][i]);
                current = current.next;
            }
            bottom--;

            for (int i = bottom; i >= top && left <= right; i--) {
                current.next = new ListNode(matrix[i][left]);
                current = current.next;
            }
            left++;
        }

        return head.next;
    }

    static class ListNode {
        int val;
        ListNode next;
        ListNode(int x) { val = x; }
    }
}