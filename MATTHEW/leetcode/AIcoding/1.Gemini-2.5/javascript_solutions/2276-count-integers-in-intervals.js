class Intervals {
    constructor() {
        this.map = new Map(); // Stores intervals: start -> end
        this.keys = []; // Sorted array of start points (keys of the map)
        this.totalCount = 0;
    }

    // Binary search to find the index where 'num' should be inserted
    // Returns the index of the first element in 'arr' that is >= 'num'.
    _binarySearch(arr, num) {
        let low = 0;
        let high = arr.length - 1;
        let ans = arr.length;

        while (low <= high) {
            let mid = Math.floor((low + high) / 2);
            if (arr[mid] >= num) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return ans;
    }

    add(number) {
        let s = number;
        let e = number;
        let keys = this.keys;
        let map = this.map;
        let totalCount = this.totalCount;

        // Find the index of the first key >= s
        let idx = this._binarySearch(keys, s);

        // Check the interval immediately before idx (potential left overlap/adjacency)
        if (idx > 0) {
            let prevS = keys[idx - 1];
            let prevE = map.get(prevS);

            if (prevE >= s) { // 'number' is already covered by [prevS, prevE]
                return;
            }
            if (prevE === s - 1) { // Adjacent to the left
                s = prevS;
                totalCount -= (prevE - prevS + 1);
                map.delete(prevS);
                keys.splice(idx - 1, 1); // Remove prevS from keys array
                idx--; // Adjust idx as an element was removed before it
            }
        }

        // Check intervals from idx onwards (potential right overlap/adjacency)
        // This loop merges all overlapping/adjacent intervals to the right
        while (idx < keys.length) {
            let nextS = keys[idx];
            let nextE = map.get(nextS);

            if (nextS <= e + 1) { // Overlaps or is adjacent to the right
                e = Math.max(e, nextE);
                totalCount -= (nextE - nextS + 1);
                map.delete(nextS);
                keys.splice(idx, 1); // Remove nextS from keys array
                // Do NOT increment idx, as the element at idx was removed, and the next element shifted to idx.
            } else {
                break; // No more overlaps/adjacencies
            }
        }

        // Insert the new merged interval
        map.set(s, e);
        keys.splice(idx, 0, s); // Insert new s at the correct position in keys array
        totalCount += (e - s + 1);

        this.totalCount = totalCount;
    }

    count() {
        return this.totalCount;
    }
}