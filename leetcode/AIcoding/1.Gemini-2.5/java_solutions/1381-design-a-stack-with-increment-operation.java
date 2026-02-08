class CustomStack {
    private int[] stack;
    private int maxSize;
    private int top; // Points to the next available position, also represents the current number of elements

    public CustomStack(int maxSize) {
        this.maxSize = maxSize;
        this.stack = new int[maxSize];
        this.top = 0;
    }

    public void push(int x) {
        if (top < maxSize) {
            stack[top] = x;
            top++;
        }
    }

    public int pop() {
        if (top == 0) {
            return -1;
        } else {
            top--;
            return stack[top];
        }
    }

    public void increment(int k, int val) {
        int limit = Math.min(k, top);
        for (int i = 0; i < limit; i++) {
            stack[i] += val;
        }
    }
}