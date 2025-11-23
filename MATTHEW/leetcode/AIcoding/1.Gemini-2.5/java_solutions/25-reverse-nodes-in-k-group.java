class Solution {
    public ListNode reverseKGroup(ListNode head, int k) {
        if (head == null || k == 1) {
            return head;
        }

        ListNode dummy = new ListNode(0);
        dummy.next = head;
        ListNode prevGroupTail = dummy;

        while (prevGroupTail.next != null) {
            ListNode kGroupHead = prevGroupTail.next;
            ListNode kGroupEndChecker = kGroupHead;
            int count = 0;
            while (kGroupEndChecker != null && count < k) {
                kGroupEndChecker = kGroupEndChecker.next;
                count++;
            }

            if (count == k) {
                ListNode currentKthNode = kGroupHead;
                for (int i = 0; i < k - 1; i++) {
                    currentKthNode = currentKthNode.next;
                }

                ListNode nextGroupStart = kGroupEndChecker;
                currentKthNode.next = null;

                ListNode newHead = reverse(kGroupHead);

                prevGroupTail.next = newHead;
                kGroupHead.next = nextGroupStart;

                prevGroupTail = kGroupHead;
            } else {
                break;
            }
        }

        return dummy.next;
    }

    private ListNode reverse(ListNode head) {
        ListNode prev = null;
        ListNode curr = head;
        while (curr != null) {
            ListNode nextTemp = curr.next;
            curr.next = prev;
            prev = curr;
            curr = nextTemp;
        }
        return prev;
    }
}