class Solution {
    public int mctFromLeafValues(int[] arr) {
        int n = arr.length;
        int ans = 0;
        Stack<Integer> stack = new Stack<>();

        for (int i = 0; i < n; i++) {
            while (!stack.isEmpty() && stack.peek() <= arr[i]) {
                int mid = stack.pop();
                if (stack.isEmpty()) {
                    ans += mid * arr[i];
                } else {
                    ans += mid * Math.min(stack.peek(), arr[i]);
                }
            }
            stack.push(arr[i]);
        }

        while (stack.size() > 1) {
            int mid = stack.pop();
            ans += mid * stack.peek();
        }

        return ans;
    }
}