public class Solution {

import java.util.Random;

public class Solution {
    private ListNode head;
    private Random rand;

    public Solution(ListNode head) {
        this.head = head;
        this.rand = new Random();
    }

    public int getRandom() {
        int result = 0;
        int count = 0;
        ListNode current = head;
        while (current != null) {
            count++;
            if (rand.nextInt(count) == 0) {
                result = current.val;
            }
            current = current.next;
        }
        return result;
    }
}
}