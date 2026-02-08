var maximumBeauty = function(items, queries) {
    items.sort((a, b) => a[0] - b[0]);
    let maxBeauty = 0;
    const maxBeautyArr = [];
    for (const [price, beauty] of items) {
        maxBeauty = Math.max(maxBeauty, beauty);
        maxBeautyArr.push([price, maxBeauty]);
    }

    const answer = [];
    for (const query of queries) {
        let left = 0, right = maxBeautyArr.length - 1;
        let best = 0;
        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (maxBeautyArr[mid][0] <= query) {
                best = maxBeautyArr[mid][1];
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        answer.push(best);
    }
    return answer;
};