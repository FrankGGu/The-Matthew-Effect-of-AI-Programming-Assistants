class Solution {
    public int sumSubarrayMin(int[] arr) {
        int mod = 1_000_000_007;
        int n = arr.length;
        long result = 0;
        long[] left = new long[n];
        long[] right = new long[n];
        Stack<Integer> stack = new Stack<>();

        for (int i = 0; i < n; i++) {
            while (!stack.isEmpty() && arr[stack.peek()] > arr[i]) {
                stack.pop();
            }
            left[i] = stack.isEmpty() ? i + 1 : i - stack.peek();
            stack.push(i);
        }

        stack.clear();

        for (int i = n - 1; i >= 0; i--) {
            while (!stack.isEmpty() && arr[stack.peek()] >= arr[i]) {
                stack.pop();
            }
            right[i] = stack.isEmpty() ? n - i : stack.peek() - i;
            stack.push(i);
        }

        for (int i = 0; i < n; i++) {
            result = (result + arr[i] * left[i] * right[i]) % mod;
        }

        return (int) result;
    }
}