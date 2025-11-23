var maxBoxesFilled = function(apples, boxes, maxStrenght) {
    apples.sort((a, b) => a - b);
    boxes.sort((a, b) => a - b);
    let boxIndex = 0;
    let appleIndex = 0;
    let count = 0;
    while (boxIndex < boxes.length && appleIndex < apples.length) {
        if (apples[appleIndex] <= boxes[boxIndex]) {
            let sum = 0;
            let numApples = 0;
            let start = appleIndex;
            while (start < apples.length && sum + apples[start] <= boxes[boxIndex] && numApples < maxStrenght) {
                sum += apples[start];
                numApples++;
                start++;
            }
            if (numApples > 0) {
                count++;
                appleIndex = start;
            } else {
                appleIndex++;
            }
            boxIndex++;
        } else {
            boxIndex++;
        }
    }
    return count;
};