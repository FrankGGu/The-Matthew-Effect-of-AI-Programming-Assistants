class RangeFreqQuery {
    constructor(arr) {
        this.map = new Map();
        for (let i = 0; i < arr.length; i++) {
            if (!this.map.has(arr[i])) {
                this.map.set(arr[i], []);
            }
            this.map.get(arr[i]).push(i);
        }
    }

    query(left, right, value) {
        if (!this.map.has(value)) return 0;
        const indices = this.map.get(value);
        const leftIndex = this.binarySearch(indices, left);
        const rightIndex = this.binarySearch(indices, right + 1);
        return rightIndex - leftIndex;
    }

    binarySearch(arr, target) {
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
}