var reorganizeString = function(S) {
    const count = new Array(26).fill(0);
    for (const char of S) {
        count[char.charCodeAt() - 'a'.charCodeAt()]++;
    }

    const maxCount = Math.max(...count);
    if (maxCount > (S.length + 1) / 2) return "";

    const result = [];
    const maxHeap = [];

    for (let i = 0; i < 26; i++) {
        if (count[i] > 0) {
            maxHeap.push([-count[i], String.fromCharCode(i + 'a'.charCodeAt())]);
        }
    }

    maxHeap.sort();

    while (maxHeap.length > 0) {
        const [negCount1, char1] = maxHeap.shift();
        result.push(char1);

        if (maxHeap.length > 0) {
            const [negCount2, char2] = maxHeap.shift();
            result.push(char2);
            if (negCount2 + 1 < 0) maxHeap.push([negCount2 + 1, char2]);
        }

        if (negCount1 + 1 < 0) maxHeap.push([negCount1 + 1, char1]);
        maxHeap.sort();
    }

    return result.join('');
};