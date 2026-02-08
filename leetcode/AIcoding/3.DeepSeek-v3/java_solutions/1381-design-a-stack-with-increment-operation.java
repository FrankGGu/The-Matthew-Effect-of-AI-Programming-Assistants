class CustomStack {
    private int[] stack;
    private int[] inc;
    private int top;

    public CustomStack(int maxSize) {
        stack = new int[maxSize];
        inc = new int[maxSize];
        top = -1;
    }

    public void push(int x) {
        if (top == stack.length - 1) return;
        top++;
        stack[top] = x;
    }

    public int pop() {
        if (top == -1) return -1;
        int res = stack[top] + inc[top];
        if (top != 0) {
            inc[top - 1] += inc[top];
        }
        inc[top] = 0;
        top--;
        return res;
    }

    public void increment(int k, int val) {
        int i = Math.min(k - 1, top);
        if (i >= 0) {
            inc[i] += val;
        }
    }
}