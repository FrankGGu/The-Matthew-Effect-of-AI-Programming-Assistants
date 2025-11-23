class CustomStack {
    private int[] stack;
    private int maxSize;
    private int top;
    private int[] increment;

    public CustomStack(int maxSize) {
        this.maxSize = maxSize;
        this.stack = new int[maxSize];
        this.increment = new int[maxSize];
        this.top = 0;
    }

    public void push(int x) {
        if (top < maxSize) {
            stack[top] = x;
            top++;
        }
    }

    public int pop() {
        if (top == 0) return -1;
        top--;
        int value = stack[top] + increment[top];
        increment[top] = 0;
        if (top > 0) increment[top - 1] += increment[top];
        return value;
    }

    public void increment(int k, int val) {
        int index = Math.min(k, top) - 1;
        if (index >= 0) {
            increment[index] += val;
        }
    }
}