class Solution {
    public int numComponents(ListNode head, int[] nums) {
        boolean[] set = new boolean[10001];
        for (int num : nums) {
            set[num] = true;
        }

        int count = 0;
        ListNode curr = head;
        while (curr != null) {
            if (set[curr.val]) {
                count++;
                while (curr != null && set[curr.val]) {
                    curr = curr.next;
                }
            } else {
                curr = curr.next;
            }
        }

        return count;
    }
}