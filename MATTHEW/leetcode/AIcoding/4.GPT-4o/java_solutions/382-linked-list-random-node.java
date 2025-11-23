import java.util.Random;

class ListNode {
    int val;
    ListNode next;
    ListNode(int x) { val = x; }
}

class Solution {
    private ListNode head;
    private Random random;

    public Solution(ListNode head) {
        this.head = head;
        this.random = new Random();
    }

    public int getRandom() {
        ListNode node = head;
        int result = node.val;
        int count = 1;

        while (node != null) {
            if (random.nextInt(count) == 0) {
                result = node.val;
            }
            node = node.next;
            count++;
        }

        return result;
    }
}