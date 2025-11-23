class Solution {
    public ListNode doubleIt(ListNode head) {
        int carry = doubleAndPropagateCarry(head);

        if (carry != 0) {
            ListNode newHead = new ListNode(carry);
            newHead.next = head;
            return newHead;
        } else {
            return head;
        }
    }

    private int doubleAndPropagateCarry(ListNode node) {
        if (node == null) {
            return 0;
        }

        int carryFromNext = doubleAndPropagateCarry(node.next);

        int doubledVal = node.val * 2 + carryFromNext;

        node.val = doubledVal % 10;

        return doubledVal / 10;
    }
}