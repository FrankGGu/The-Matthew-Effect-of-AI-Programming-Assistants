class Solution {
    public ListNode mergeInBetween(ListNode list1, int a, int b, ListNode list2) {
        ListNode preA = null;
        ListNode postB = null;
        ListNode curr = list1;
        int count = 0;

        while (curr != null) {
            if (count == a - 1) {
                preA = curr;
            }
            if (count == b) {
                postB = curr.next;
                break;
            }
            curr = curr.next;
            count++;
        }

        preA.next = list2;
        curr = list2;
        while (curr.next != null) {
            curr = curr.next;
        }
        curr.next = postB;

        return list1;
    }
}