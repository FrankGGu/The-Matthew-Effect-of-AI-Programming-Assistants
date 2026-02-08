class Solution {
    public ListNode mergeInBetween(ListNode list1, int a, int b, ListNode list2) {
        ListNode dummyHead = new ListNode(0);
        dummyHead.next = list1;

        ListNode prevA = dummyHead;
        for (int i = 0; i < a; i++) {
            prevA = prevA.next;
        }

        ListNode nodeB_next = dummyHead;
        for (int i = 0; i < b + 1; i++) {
            nodeB_next = nodeB_next.next;
        }

        prevA.next = list2;

        ListNode currentList2 = list2;
        while (currentList2.next != null) {
            currentList2 = currentList2.next;
        }

        currentList2.next = nodeB_next;

        return dummyHead.next;
    }
}