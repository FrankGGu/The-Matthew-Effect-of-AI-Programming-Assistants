public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> nextLargerNode(ListNode head) {
        List<Integer> result = new ArrayList<>();
        Stack<int[]> stack = new Stack<>();
        int index = 0;

        while (head != null) {
            while (!stack.isEmpty() && stack.peek()[1] < head.val) {
                int[] node = stack.pop();
                result.set(node[0], head.val);
            }

            stack.push(new int[]{index, head.val});
            result.add(0);
            head = head.next;
            index++;
        }

        return result;
    }
}
}