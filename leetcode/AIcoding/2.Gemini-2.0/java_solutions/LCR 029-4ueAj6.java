public class Solution {
    public ListNode insert(ListNode head, int insertVal) {
        ListNode newNode = new ListNode(insertVal);

        if (head == null) {
            newNode.next = newNode;
            return newNode;
        }

        ListNode curr = head;
        ListNode next = head.next;

        while (next != head) {
            if (curr.val <= insertVal && insertVal <= next.val) {
                break;
            }

            if (curr.val > next.val && (insertVal >= curr.val || insertVal <= next.val)) {
                break;
            }

            curr = next;
            next = next.next;
        }

        newNode.next = next;
        curr.next = newNode;

        return head;
    }

     public static class ListNode {
         public int val;
         public ListNode next;
         ListNode() {}
         public ListNode(int val) { this.val = val; }
         ListNode(int val, ListNode next) { this.val = val; this.next = next; }
     }
}