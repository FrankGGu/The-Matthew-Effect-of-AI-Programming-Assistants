class FenwickTree {
    constructor(size) {
        this.tree = new Array(size + 1).fill(0);
        this.size = size;
    }

    update(idx, delta) { // idx is 1-based
        while (idx <= this.size) {
            this.tree[idx] += delta;
            idx += idx & (-idx);
        }
    }

    query(idx) { // idx is 1-based, returns sum from 1 to idx
        let sum = 0;
        while (idx > 0) {
            sum += this.tree[idx];
            idx -= idx & (-idx);
        }
        return sum;
    }
}

function minInteger(num, k) {
    const n = num.length;
    const pos = Array.from({ length: 10 }, () => []); // Stores original 0-indexed positions for each digit
    for (let i = 0; i < n; i++) {
        pos[parseInt(num[i])].push(i);
    }

    const ft = new FenwickTree(n); // Fenwick tree to track picked original indices
    const result = [];
    const idxPointers = new Array(10).fill(0); // Pointers for each digit's position list

    for (let i = 0; i < n; i++) { // i is the current target position in the result string
        let pickedDigit = -1;
        let pickedOriginalIdx = -1;
        let minCost = Infinity;

        for (let d = 0; d <= 9; d++) {
            // Advance pointer for 'd' if digits are effectively too far left
            while (idxPointers[d] < pos[d].length) {
                const tempOriginalIdx = pos[d][idxPointers[d]];
                // ft.query(tempOriginalIdx) counts elements picked with original index < tempOriginalIdx
                const tempPickedBefore = ft.query(tempOriginalIdx); 
                const tempCurrentEffectiveIdx = tempOriginalIdx - tempPickedBefore;

                if (tempCurrentEffectiveIdx < i) {
                    idxPointers[d]++; // This digit is effectively before target position 'i', skip it
                } else {
                    break; // This digit is at or after target position 'i'
                }
            }

            // If all occurrences of digit 'd' have been processed or skipped
            if (idxPointers[d] >= pos[d].length) {
                continue;
            }

            const originalIdx = pos[d][idxPointers[d]];
            const pickedBefore = ft.query(originalIdx); 
            const currentEffectiveIdx = originalIdx - pickedBefore;
            const cost = currentEffectiveIdx - i;

            if (cost <= k) {
                // This is the smallest digit 'd' that can be moved to position 'i' within 'k' swaps.
                // Since we iterate 'd' from 0 to 9, the first one satisfying the condition is the best.
                pickedDigit = d;
                pickedOriginalIdx = originalIdx;
                minCost = cost; // Store cost for k reduction
                break; // Found the optimal digit for current position 'i'
            }
        }

        if (pickedDigit !== -1) {
            result.push(pickedDigit.toString());
            k -= minCost;
            ft.update(pickedOriginalIdx + 1, 1); // Mark original index as picked (1-based for Fenwick Tree)
            idxPointers[pickedDigit]++; // Advance pointer for this digit
        } else {
            // If no digit could be picked for the current position 'i',
            // it means 'k' is exhausted or too small for any beneficial swap.
            // Append all remaining unpicked digits in their original relative order.
            for (let j = 0; j < n; j++) {
                // Check if original index 'j' has been picked using Fenwick Tree
                // ft.query(j + 1) - ft.query(j) == 0 means original index 'j' is not picked
                if (ft.query(j + 1) - ft.query(j) === 0) { 
                    result.push(num[j]);
                }
            }
            break; // All remaining digits are appended, terminate the main loop
        }
    }

    return result.join('');
}