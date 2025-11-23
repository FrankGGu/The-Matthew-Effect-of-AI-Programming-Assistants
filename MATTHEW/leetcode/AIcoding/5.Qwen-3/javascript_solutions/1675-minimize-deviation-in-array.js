function minimumDeviation(nums) {
    let minHeap = [];
    let maxVal = -Infinity;

    for (let num of nums) {
        if (num % 2 === 1) {
            num *= 2;
        }
        minHeap.push(num);
        maxVal = Math.max(maxVal, num);
    }

    let minDeviation = Infinity;
    let heap = minHeap;

    function heapify(arr, i) {
        let left = 2 * i + 1;
        let right = 2 * i + 2;
        let smallest = i;

        if (left < arr.length && arr[left] < arr[smallest]) {
            smallest = left;
        }
        if (right < arr.length && arr[right] < arr[smallest]) {
            smallest = right;
        }
        if (smallest !== i) {
            [arr[i], arr[smallest]] = [arr[smallest], arr[i]];
            heapify(arr, smallest);
        }
    }

    function buildHeap(arr) {
        for (let i = Math.floor(arr.length / 2); i >= 0; i--) {
            heapify(arr, i);
        }
    }

    buildHeap(heap);

    while (true) {
        let currentMin = heap[0];
        minDeviation = Math.min(minDeviation, maxVal - currentMin);

        if (currentMin % 2 === 1) {
            break;
        }

        let newNum = currentMin / 2;
        heap[0] = newNum;
        heapify(heap, 0);
        maxVal = Math.max(maxVal, newNum);
    }

    return minDeviation;
}