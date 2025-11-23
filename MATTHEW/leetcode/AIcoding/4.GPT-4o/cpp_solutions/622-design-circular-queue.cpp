class MyCircularQueue {
public:
    vector<int> queue;
    int head, tail, size, capacity;

    MyCircularQueue(int k) {
        capacity = k;
        queue.resize(k);
        head = 0;
        tail = 0;
        size = 0;
    }

    bool enQueue(int value) {
        if (isFull()) return false;
        queue[tail] = value;
        tail = (tail + 1) % capacity;
        size++;
        return true;
    }

    bool deQueue() {
        if (isEmpty()) return false;
        head = (head + 1) % capacity;
        size--;
        return true;
    }

    int Front() {
        if (isEmpty()) return -1;
        return queue[head];
    }

    int Rear() {
        if (isEmpty()) return -1;
        return queue[(tail - 1 + capacity) % capacity];
    }

    bool isEmpty() {
        return size == 0;
    }

    bool isFull() {
        return size == capacity;
    }
};