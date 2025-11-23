class MajorityChecker {
    constructor(arr) {
        this.arr = arr;
        this.indexMap = new Map();
        for (let i = 0; i < arr.length; i++) {
            if (!this.indexMap.has(arr[i])) {
                this.indexMap.set(arr[i], []);
            }
            this.indexMap.get(arr[i]).push(i);
        }
    }

    query(left, right, threshold) {
        const countMap = new Map();
        for (let i = left; i <= right; i++) {
            const num = this.arr[i];
            if (!countMap.has(num)) {
                countMap.set(num, 0);
            }
            countMap.set(num, countMap.get(num) + 1);
            if (countMap.get(num) >= threshold) {
                return num;
            }
        }
        return -1;
    }
}