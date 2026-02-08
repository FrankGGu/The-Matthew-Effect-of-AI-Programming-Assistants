class MedianFinder {
    constructor() {
        this.left = new MaxPriorityQueue();
        this.right = new MinPriorityQueue();
    }

    addNum(num) {
        this.left.enqueue(num);
        this.right.enqueue(this.left.dequeue().element);

        if (this.left.size() < this.right.size()) {
            this.left.enqueue(this.right.dequeue().element);
        }
    }

    findMedian() {
        if (this.left.size() > this.right.size()) {
            return this.left.front().element;
        }
        return (this.left.front().element + this.right.front().element) / 2;
    }
}

var medianSlidingWindow = function(nums, k) {
    const result = [];
    const mf = new MedianFinder();

    for (let i = 0; i < nums.length; i++) {
        mf.addNum(nums[i]);
        if (i >= k - 1) {
            result.push(mf.findMedian());
            mf.removeNum(nums[i - k + 1]);
        }
    }

    return result;
};