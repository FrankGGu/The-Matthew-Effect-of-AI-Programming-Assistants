#include <vector>

class MyCircularDeque {
private:
    std::vector<int> data;
    int head;
    int tail;
    int capacity;
    int count;

public:
    MyCircularDeque(int k) {
        data.resize(k);
        capacity = k;
        head = 0;
        tail = 0;
        count = 0;
    }

    bool insertFront(int value) {
        if (isFull()) {
            return false;
        }
        head = (head - 1 + capacity) % capacity;
        data[head] = value;
        count++;
        return true;
    }

    bool insertLast(int value) {
        if (isFull()) {
            return false;
        }
        data[tail] = value;
        tail = (tail + 1) % capacity;
        count++;
        return true;
    }

    bool deleteFront() {
        if (isEmpty()) {
            return false;
        }
        head = (head + 1) % capacity;
        count--;
        return true;
    }

    bool deleteLast() {
        if (isEmpty()) {
            return false;
        }
        tail = (tail - 1 + capacity) % capacity;
        count--;
        return true;
    }

    int getFront() {
        if (isEmpty()) {
            return -1;
        }
        return data[head];
    }

    int getRear() {
        if (isEmpty()) {
            return -1;
        }
        int rear_index = (tail - 1 + capacity) % capacity;
        return data[rear_index];
    }

    bool isEmpty() {
        return count == 0;
    }

    bool isFull() {
        return count == capacity;
    }
};