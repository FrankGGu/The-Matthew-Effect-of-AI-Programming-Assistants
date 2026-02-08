var distributeElements = function(nums) {
    class FenwickTree {
        constructor(size) {
            this.tree = new Array(size + 1).fill(0);
            this.size = size;
        }

        update(index, delta) {
            index++; 
            while (index <= this.size) {
                this.tree[index] += delta;
                index += index & (-index);
            }
        }

        query(index) {
            index++; 
            let sum = 0;
            while (index > 0) {
                sum += this.tree[index];
                index -= index & (-index);
            }
            return sum;
        }
    }

    const n = nums.length;

    const allValues = [...new Set(nums)];
    allValues.sort((a, b) => a - b);
    const valueToCompressedIndex = new Map();
    for (let i = 0; i < allValues.length; i++) {
        valueToCompressedIndex.set(allValues[i], i);
    }
    const M = allValues.length;

    const arr1 = [nums[0]];
    const arr2 = [nums[1]];

    const bit1 = new FenwickTree(M);
    const bit2 = new FenwickTree(M);

    bit1.update(valueToCompressedIndex.get(nums[0]), 1);
    bit2.update(valueToCompressedIndex.get(nums[1]), 1);

    for (let i = 2; i < n; i++) {
        const currentNum = nums[i];
        const compressedIdx = valueToCompressedIndex.get(currentNum);

        const totalElementsInArr1 = arr1.length;
        const totalElementsInArr2 = arr2.length;

        const count1 = totalElementsInArr1 - bit1.query(compressedIdx);
        const count2 = totalElementsInArr2 - bit2.query(compressedIdx);

        if (count1 > count2) {
            arr1.push(currentNum);
            bit1.update(compressedIdx, 1);
        } else if (count2 > count1) {
            arr2.push(currentNum);
            bit2.update(compressedIdx, 1);
        } else {
            if (totalElementsInArr1 <= totalElementsInArr2) {
                arr1.push(currentNum);
                bit1.update(compressedIdx, 1);
            } else {
                arr2.push(currentNum);
                bit2.update(compressedIdx, 1);
            }
        }
    }

    return arr1.concat(arr2);
};