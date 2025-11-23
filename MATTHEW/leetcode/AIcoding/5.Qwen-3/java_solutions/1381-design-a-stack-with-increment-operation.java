public class Solution {

import java.util.*;

public class CustomStack {
    private int[] stack;
    private int size;
    private int capacity;

    public CustomStack(int maxSize) {
        this.capacity = maxSize;
        this.stack = new int[maxSize];
        this.size = 0;
    }

    public void push(int x) {
        if (size < capacity) {
            stack[size++] = x;
        }
    }

    public int pop() {
        if (size == 0) {
            throw new RuntimeException("Stack is empty");
        }
        return stack[--size];
    }

    public void increment(int k, int val) {
        int limit = Math.min(k, size);
        for (int i = 0; i < limit; i++) {
            stack[i] += val;
        }
    }
}
}