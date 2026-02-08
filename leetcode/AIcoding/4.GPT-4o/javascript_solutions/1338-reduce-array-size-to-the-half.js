function minSetSize(arr) {
    const freqMap = new Map();
    for (const num of arr) {
        freqMap.set(num, (freqMap.get(num) || 0) + 1);
    }

    const frequencies = Array.from(freqMap.values()).sort((a, b) => b - a);
    let count = 0, size = 0;

    for (const freq of frequencies) {
        count += freq;
        size++;
        if (count >= arr.length / 2) {
            return size;
        }
    }

    return size;
}