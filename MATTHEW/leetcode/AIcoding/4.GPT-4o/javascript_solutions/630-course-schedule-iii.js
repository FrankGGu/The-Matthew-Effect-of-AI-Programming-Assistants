var scheduleCourse = function(courses) {
    courses.sort((a, b) => a[1] - b[1]);
    const maxHeap = [];
    let totalTime = 0;

    for (const [duration, end] of courses) {
        totalTime += duration;
        maxHeap.push(duration);
        if (totalTime > end) {
            maxHeap.sort((a, b) => b - a);
            totalTime -= maxHeap.shift();
        }
    }

    return maxHeap.length;
};