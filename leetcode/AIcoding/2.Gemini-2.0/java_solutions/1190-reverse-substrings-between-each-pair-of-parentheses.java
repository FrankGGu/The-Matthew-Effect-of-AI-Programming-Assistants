import java.util.Deque;
import java.util.LinkedList;

class Solution {
    public String reverseParentheses(String s) {
        Deque<Integer> stack = new LinkedList<>();
        char[] arr = s.toCharArray();
        for (int i = 0; i < arr.length; i++) {
            if (arr[i] == '(') {
                stack.push(i);
            } else if (arr[i] == ')') {
                int start = stack.pop();
                reverse(arr, start + 1, i - 1);
            }
        }
        StringBuilder sb = new StringBuilder();
        for (char c : arr) {
            if (c != '(' && c != ')') {
                sb.append(c);
            }
        }
        return sb.toString();
    }

    private void reverse(char[] arr, int start, int end) {
        while (start < end) {
            char temp = arr[start];
            arr[start] = arr[end];
            arr[end] = temp;
            start++;
            end--;
        }
    }
}