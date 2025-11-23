function minimumNumbers(chairs, num) {
    let occupied = new Array(100).fill(0);
    for (let chair of chairs) {
        occupied[chair] = 1;
    }

    let maxChairs = 0;
    for (let i = 0; i < occupied.length; i++) {
        let count = 0;
        for (let j = i; j < occupied.length; j++) {
            count += occupied[j];
            if (count === num) {
                maxChairs = Math.max(maxChairs, j - i + 1);
            }
            if (count > num) {
                break;
            }
        }
    }

    return maxChairs;
}