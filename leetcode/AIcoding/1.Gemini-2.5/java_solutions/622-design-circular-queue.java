class MyCircularQueue {
    private int[] queue;
    private int head;
    private int tail;
    private int size;
    private int count;

    public MyCircularQueue(int k) {
        size = k;
        queue = new int[k];
        head = -1;
        tail = -1;
        count = 0;
    }

    public boolean enQueue(int value) {
        if (isFull()) {
            return false;
        }
        if (isEmpty()) {
            head = 0;
        }
        tail = (tail + 1) % size;
        queue[tail] = value;
        count++;
        return true;
    }

    public boolean deQueue() {
        if (isEmpty()) {
            return false;
        }
        head = (head + 1) % size;
        count--;
        if (count == 0) {
            head = -1;
            tail = -1;
        }
        return true;
    }

    public int Front() {
        if (isEmpty()) {
            return -1;
        }
        return queue[head];
    }

    public int Rear() {
        if (isEmpty()) {
            return -1;
        }
        return queue[tail];
    }

    public boolean isEmpty() {
        return count == 0;
    }

    public boolean isFull() {
        return count == size;
    }
}