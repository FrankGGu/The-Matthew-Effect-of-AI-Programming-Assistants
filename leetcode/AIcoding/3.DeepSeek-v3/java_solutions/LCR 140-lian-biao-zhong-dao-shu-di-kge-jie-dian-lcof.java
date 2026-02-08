class Solution {
    public ListNode trainingPlan(ListNode head, int cnt) {
        ListNode fast = head;
        ListNode slow = head;
        for (int i = 0; i < cnt; i++) {
            fast = fast.next;
        }
        while (fast != null) {
            fast = fast.next;
            slow = slow.next;
        }
        return slow;
    }
}