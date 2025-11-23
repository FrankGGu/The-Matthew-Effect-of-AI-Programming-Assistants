class MyCircularDeque {
    private int[] data;
    private int front;
    private int rear; // rear points to the next available slot
    private int capacity;
    private int count; // current number of elements

    public MyCircularDeque(int k) {
        capacity = k;
        data = new int[k];
        front = 0;
        rear = 0;
        count = 0;
    }

    public boolean insertFront(int value) {
        if (isFull()) {
            return false;
        }
        front = (front - 1 + capacity) % capacity;
        data[front] = value;
        count++;
        return true;
    }

    public boolean insertLast(int value) {
        if (isFull()) {
            return false;
        }
        data[rear] = value;
        rear = (rear + 1) % capacity;
        count++;
        return true;
    }

    public boolean deleteFront() {
        if (isEmpty()) {
            return false;
        }
        front = (front + 1) % capacity;
        count--;
        return true;
    }

    public boolean deleteLast() {
        if (isEmpty()) {
            return false;
        }
        rear = (rear - 1 + capacity) % capacity;
        count--;
        return true;
    }

    public int getFront() {
        if (isEmpty()) {
            return -1;
        }
        return data[front];
    }

    public int getRear() {
        if (isEmpty()) {
            return -1;
        }
        // rear points to the next available slot, so the last element is at (rear - 1 + capacity) % capacity
        return data[(rear - 1 + capacity) % capacity];
    }

    public boolean isEmpty() {
        return count == 0;
    }

    public boolean isFull() {
        return count == capacity;
    }
}