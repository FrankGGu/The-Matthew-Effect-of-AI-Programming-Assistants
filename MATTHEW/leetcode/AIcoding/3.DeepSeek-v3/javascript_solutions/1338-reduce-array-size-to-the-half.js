var minSetSize = function(arr) {
    const frequencyMap = new Map();
    for (const num of arr) {
        frequencyMap.set(num, (frequencyMap.get(num) || 0) + 1);
    }

    const frequencies = Array.from(frequencyMap.values());
    frequencies.sort((a, b) => b - a);

    let total = 0;
    let count = 0;
    const half = arr.length / 2;

    for (const freq of frequencies) {
        total += freq;
        count++;
        if (total >= half) {
            break;
        }
    }

    return count;
};