var intervalIntersection = function(firstList, secondList) {
    let i = 0;
    let j = 0;
    const result = [];

    while (i < firstList.length && j < secondList.length) {
        const start1 = firstList[i][0];
        const end1 = firstList[i][1];
        const start2 = secondList[j][0];
        const end2 = secondList[j][1];

        const intersectionStart = Math.max(start1, start2);
        const intersectionEnd = Math.min(end1, end2);

        if (intersectionStart <= intersectionEnd) {
            result.push([intersectionStart, intersectionEnd]);
        }

        if (end1 < end2) {
            i++;
        } else {
            j++;
        }
    }

    return result;
};