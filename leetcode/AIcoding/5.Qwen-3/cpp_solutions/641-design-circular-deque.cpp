#include <iostream>
#include <vector>

using namespace std;

class Solution {
private:
    vector<int> deque;
    int capacity;
    int front;
    int rear;
    int size;

public:
    Solution(int k) {
        capacity = k;
        deque.resize(k);
        front = 0;
        rear = 0;
        size = 0;
    }

    bool insertFront(int value) {
        if (size == capacity) return false;
        front = (front - 1 + capacity) % capacity;
        deque[front] = value;
        size++;
        return true;
    }

    bool insertLast(int value) {
        if (size == capacity) return false;
        deque[rear] = value;
        rear = (rear + 1) % capacity;
        size++;
        return true;
    }

    bool deleteFront() {
        if (size == 0) return false;
        front = (front + 1) % capacity;
        size--;
        return true;
    }

    bool deleteLast() {
        if (size == 0) return false;
        rear = (rear - 1 + capacity) % capacity;
        size--;
        return true;
    }

    int getFront() {
        if (size == 0) return -1;
        return deque[front];
    }

    int getRear() {
        if (size == 0) return -1;
        return deque[(rear - 1 + capacity) % capacity];
    }

    bool isEmpty() {
        return size == 0;
    }

    bool isFull() {
        return size == capacity;
    }
};