import java.util.Random;

class Solution {

    private ListNode head;
    private Random random;

    public Solution(ListNode head) {
        this.head = head;
        this.random = new Random();
    }

    public int getRandom() {
        int result = head.val;
        ListNode current = head.next;
        int n = 2;
        while (current != null) {
            if (random.nextInt(n) == 0) {
                result = current.val;
            }
            n++;
            current = current.next;
        }
        return result;
    }
}