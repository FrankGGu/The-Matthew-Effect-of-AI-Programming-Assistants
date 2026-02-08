var kSum = function(nums, k) {
    let sum = 0;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] > 0) {
            sum += nums[i];
        } else {
            nums[i] = -nums[i];
        }
    }
    nums.sort((a, b) => a - b);

    const heap = [];
    heap.push([0, 0]);

    for (let i = 0; i < k - 1; i++) {
        const [currentSum, index] = heap[0];
        heap[0] = heap[heap.length - 1];
        heap.pop();
        let j = heap.length;
        while (j > 0) {
            const parent = Math.floor((j - 1) / 2);
            if (heap[parent][0] > heap[j][0]) {
                [heap[parent], heap[j]] = [heap[j], heap[parent]];
                j = parent;
            } else {
                break;
            }
        }

        if (index < nums.length) {
            heap.push([currentSum + nums[index], index + 1]);
            let k = heap.length - 1;
            while (k > 0) {
                const parent = Math.floor((k - 1) / 2);
                if (heap[parent][0] > heap[k][0]) {
                    [heap[parent], heap[k]] = [heap[k], heap[parent]];
                    k = parent;
                } else {
                    break;
                }
            }

            if (index + 1 < nums.length) {
                heap.push([currentSum + nums[index + 1] - nums[index], index + 2]);
                let l = heap.length - 1;
                while (l > 0) {
                    const parent = Math.floor((l - 1) / 2);
                    if (heap[parent][0] > heap[l][0]) {
                        [heap[parent], heap[l]] = [heap[l], heap[parent]];
                        l = parent;
                    } else {
                        break;
                    }
                }
            }
        }
    }

    return sum - heap[0][0];
};