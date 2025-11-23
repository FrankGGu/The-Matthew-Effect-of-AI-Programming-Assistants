public class MyCircularQueue {
    private int[] queue;
    private int front;
    private int rear;
    private int capacity;
    private int size;

    public MyCircularQueue(int k) {
        queue = new int[k];
        capacity = k;
        front = 0;
        rear = 0;
        size = 0;
    }

    public boolean enQueue(int value) {
        if (size == capacity) {
            return false;
        }
        queue[rear] = value;
        rear = (rear + 1) % capacity;
        size++;
        return true;
    }

    public boolean deQueue() {
        if (size == 0) {
            return false;
        }
        front = (front + 1) % capacity;
        size--;
        return true;
    }

    public int Front() {
        if (size == 0) {
            return -1;
        }
        return queue[front];
    }

    public int Rear() {
        if (size == 0) {
            return -1;
        }
        return queue[(rear - 1 + capacity) % capacity];
    }

    public boolean isEmpty() {
        return size == 0;
    }

    public boolean isFull() {
        return size == capacity;
    }
}