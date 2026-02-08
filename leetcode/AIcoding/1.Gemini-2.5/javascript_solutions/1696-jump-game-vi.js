class Deque {
    constructor() {
        this.data = [];
        this.head = 0;
        this.tail = 0;
    }

    pushBack(val) {
        this.data[this.tail] = val;
        this.tail++;
    }

    popBack() {
        if (this.isEmpty()) return undefined;
        this.tail--;
        const val = this.data[this.tail];
        return val;
    }

    peekBack() {
        if (this.isEmpty()) return undefined;
        return this.data[this.tail - 1];
    }

    popFront() {
        if (this.isEmpty()) return undefined;
        const val = this.data[this.head];
        this.head++;
        return val;
    }

    peekFront() {
        if (this.isEmpty()) return undefined;
        return this.data[this.head];
    }

    isEmpty() {
        return this.head === this.tail;
    }
}

var maxResult = function(nums, k) {
    const n = nums.length;
    const dp = new Array(n);
    const deque = new Deque();

    dp[0] = nums[0];
    deque.pushBack(0);

    for (let i = 1; i < n; i++) {
        while (!deque.isEmpty() && deque.peekFront() < i - k) {
            deque.popFront();
        }

        dp[i] = nums[i] + dp[deque.peekFront()];

        while (!deque.isEmpty() && dp[deque.peekBack()] <= dp[i]) {
            deque.popBack();
        }

        deque.pushBack(i);
    }

    return dp[n - 1];
};