var Solution = function(rects) {
    this.rects = rects;
    this.prefixSums = [];
    let currentSum = 0;

    for (let i = 0; i < rects.length; i++) {
        const [x1, y1, x2, y2] = rects[i];
        // Calculate the number of integer points in the current rectangle
        // Width = x2 - x1 + 1, Height = y2 - y1 + 1
        const pointsInRect = (x2 - x1 + 1) * (y2 - y1 + 1);
        currentSum += pointsInRect;
        this.prefixSums.push(currentSum);
    }
    this.totalPoints = currentSum;
};

Solution.prototype.pick = function() {
    // Generate a random number from 0 (inclusive) to totalPoints (exclusive)
    // This represents a random "index" among all possible integer points.
    const targetPointIndex = Math.floor(Math.random() * this.totalPoints);

    // Use binary search to find which rectangle this targetPointIndex falls into.
    // The prefixSums array stores the cumulative count of points.
    // We are looking for the first index 'mid' where prefixSums[mid] > targetPointIndex.
    let low = 0;
    let high = this.prefixSums.length - 1;
    let chosenRectIndex = -1;

    while (low <= high) {
        const mid = Math.floor((low + high) / 2);
        if (this.prefixSums[mid] > targetPointIndex) {
            chosenRectIndex = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    const [x1, y1, x2, y2] = this.rects[chosenRectIndex];

    // Pick a random integer point within the chosen rectangle.
    // For x: random value between x1 and x2 (inclusive)
    // For y: random value between y1 and y2 (inclusive)
    const randomX = x1 + Math.floor(Math.random() * (x2 - x1 + 1));
    const randomY = y1 + Math.floor(Math.random() * (y2 - y1 + 1));

    return [randomX, randomY];
};