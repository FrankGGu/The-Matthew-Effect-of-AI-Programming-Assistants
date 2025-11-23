class Solution {
    public ListNode insertGreatestCommonDivisors(ListNode head) {
        if (head == null || head.next == null) {
            return head;
        }

        ListNode current = head;
        while (current != null && current.next != null) {
            int val1 = current.val;
            int val2 = current.next.val;

            int commonDivisor = gcd(val1, val2);

            ListNode newNode = new ListNode(commonDivisor);

            newNode.next = current.next;
            current.next = newNode;

            current = newNode.next;
        }

        return head;
    }

    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}