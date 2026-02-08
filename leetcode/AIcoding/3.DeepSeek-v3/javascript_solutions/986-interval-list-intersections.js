var intervalIntersection = function(firstList, secondList) {
    let i = 0, j = 0;
    const result = [];

    while (i < firstList.length && j < secondList.length) {
        const [startA, endA] = firstList[i];
        const [startB, endB] = secondList[j];

        const start = Math.max(startA, startB);
        const end = Math.min(endA, endB);

        if (start <= end) {
            result.push([start, end]);
        }

        if (endA < endB) {
            i++;
        } else {
            j++;
        }
    }

    return result;
};