import java.util.Random;

class Solution {
    private ListNode head;
    private Random random;

    public Solution(ListNode head) {
        this.head = head;
        this.random = new Random();
    }

    public int getRandom() {
        int count = 0;
        int result = 0;
        ListNode current = head;
        while (current != null) {
            count++;
            if (random.nextInt(count) == 0) {
                result = current.val;
            }
            current = current.next;
        }
        return result;
    }
}