var minSetSize = function(arr) {
    const freqMap = new Map();
    for (const num of arr) {
        freqMap.set(num, (freqMap.get(num) || 0) + 1);
    }

    const frequencies = Array.from(freqMap.values());
    frequencies.sort((a, b) => b - a);

    const halfSize = arr.length / 2;
    let currentRemovedCount = 0;
    let setCount = 0;

    for (let i = 0; i < frequencies.length; i++) {
        currentRemovedCount += frequencies[i];
        setCount++;
        if (currentRemovedCount >= halfSize) {
            break;
        }
    }

    return setCount;
};