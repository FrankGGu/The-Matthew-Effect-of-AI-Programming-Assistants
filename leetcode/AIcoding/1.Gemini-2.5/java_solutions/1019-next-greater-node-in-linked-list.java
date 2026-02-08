import java.util.ArrayList;
import java.util.Stack;

class Solution {
    public int[] nextLargerNodes(ListNode head) {
        ArrayList<Integer> values = new ArrayList<>();
        ListNode current = head;
        while (current != null) {
            values.add(current.val);
            current = current.next;
        }

        int n = values.size();
        int[] result = new int[n];
        Stack<Integer> stack = new Stack<>(); 

        for (int i = 0; i < n; i++) {
            int currentValue = values.get(i);
            while (!stack.isEmpty() && values.get(stack.peek()) < currentValue) {
                result[stack.pop()] = currentValue;
            }
            stack.push(i);
        }

        return result;
    }
}