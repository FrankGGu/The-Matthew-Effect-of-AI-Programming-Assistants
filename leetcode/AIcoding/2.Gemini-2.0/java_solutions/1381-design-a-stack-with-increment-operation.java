class CustomStack {

    private int[] stack;
    private int maxSize;
    private int top;

    public CustomStack(int maxSize) {
        this.maxSize = maxSize;
        this.stack = new int[maxSize];
        this.top = -1;
    }

    public void push(int x) {
        if (top < maxSize - 1) {
            stack[++top] = x;
        }
    }

    public int pop() {
        if (top == -1) {
            return -1;
        }
        return stack[top--];
    }

    public void increment(int k, int val) {
        for (int i = 0; i <= Math.min(k - 1, top); i++) {
            stack[i] += val;
        }
    }
}