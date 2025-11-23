class MajorityChecker {
    constructor(arr) {
        this.arr = arr;
        this.map = new Map();
        for (let i = 0; i < arr.length; i++) {
            if (!this.map.has(arr[i])) {
                this.map.set(arr[i], []);
            }
            this.map.get(arr[i]).push(i);
        }
    }

    query(left, right, threshold) {
        for (let i = 0; i < 20; i++) {
            const randIndex = left + Math.floor(Math.random() * (right - left + 1));
            const num = this.arr[randIndex];
            const indices = this.map.get(num);
            const leftPos = this.lowerBound(indices, left);
            const rightPos = this.upperBound(indices, right);
            const count = rightPos - leftPos;
            if (count >= threshold) {
                return num;
            }
        }
        return -1;
    }

    lowerBound(arr, target) {
        let left = 0, right = arr.length;
        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (arr[mid] < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }

    upperBound(arr, target) {
        let left = 0, right = arr.length;
        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (arr[mid] <= target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }
}