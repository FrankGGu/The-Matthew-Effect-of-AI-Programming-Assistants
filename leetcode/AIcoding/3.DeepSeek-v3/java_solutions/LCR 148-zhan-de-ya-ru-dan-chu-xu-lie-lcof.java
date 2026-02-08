class Solution {
    public boolean validateBookSequences(int[] putIn, int[] takeOut) {
        Stack<Integer> stack = new Stack<>();
        int i = 0;
        for (int num : putIn) {
            stack.push(num);
            while (!stack.isEmpty() && stack.peek() == takeOut[i]) {
                stack.pop();
                i++;
            }
        }
        return stack.isEmpty();
    }
}