class RangeFreqQuery {
    constructor(arr) {
        this.valIndices = new Map();
        for (let i = 0; i < arr.length; i++) {
            const val = arr[i];
            if (!this.valIndices.has(val)) {
                this.valIndices.set(val, []);
            }
            this.valIndices.get(val).push(i);
        }
    }

    query(left, right, value) {
        if (!this.valIndices.has(value)) {
            return 0;
        }

        const indices = this.valIndices.get(value);

        // Find the first index in 'indices' that is >= left (lower_bound)
        let low = 0;
        let high = indices.length - 1;
        let startIndex = indices.length; 

        while (low <= high) {
            let mid = Math.floor((low + high) / 2);
            if (indices[mid] >= left) {
                startIndex = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        // Find the first index in 'indices' that is > right (upper_bound)
        low = 0;
        high = indices.length - 1;
        let endIndex = indices.length; 

        while (low <= high) {
            let mid = Math.floor((low + high) / 2);
            if (indices[mid] > right) {
                endIndex = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        return endIndex - startIndex;
    }
}