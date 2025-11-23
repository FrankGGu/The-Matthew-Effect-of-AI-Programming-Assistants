#include <iostream>
#include <vector>

using namespace std;

class Solution {
private:
    vector<int> data;
    int front;
    int rear;
    int capacity;

public:
    Solution(int k) {
        data.resize(k);
        capacity = k;
        front = 0;
        rear = 0;
    }

    bool enQueue(int value) {
        if (isFull()) {
            return false;
        }
        data[rear] = value;
        rear = (rear + 1) % capacity;
        return true;
    }

    bool deQueue() {
        if (isEmpty()) {
            return false;
        }
        front = (front + 1) % capacity;
        return true;
    }

    int Front() {
        if (isEmpty()) {
            return -1;
        }
        return data[front];
    }

    int Rear() {
        if (isEmpty()) {
            return -1;
        }
        return data[(rear - 1 + capacity) % capacity];
    }

    bool isEmpty() {
        return front == rear;
    }

    bool isFull() {
        return (rear + 1) % capacity == front;
    }
};