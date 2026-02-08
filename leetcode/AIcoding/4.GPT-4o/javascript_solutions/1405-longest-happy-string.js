function longestDiverseString(a, b, c) {
    let result = '';

    const maxHeap = [];
    if (a > 0) maxHeap.push([-a, 'a']);
    if (b > 0) maxHeap.push([-b, 'b']);
    if (c > 0) maxHeap.push([-c, 'c']);

    while (maxHeap.length > 0) {
        maxHeap.sort();
        const first = maxHeap[0];
        const second = maxHeap[1] || [0, ''];

        if (first[0] < -2) {
            result += first[1].repeat(2);
            first[0] += 2;
        } else if (first[0] < 0) {
            result += first[1];
            first[0] += 1;
        } else {
            break;
        }

        if (second[0] < 0) {
            result += second[1];
            second[0] += 1;
        }

        if (first[0] < 0) maxHeap.shift();
        if (second[0] < 0 && second[0] !== 0) maxHeap.splice(1, 1);
    }

    return result;
}