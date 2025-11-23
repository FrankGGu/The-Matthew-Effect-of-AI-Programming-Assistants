function scheduleCourse(course) {
    course.sort((a, b) => a[1] - b[1]);
    const maxHeap = [];
    let time = 0;

    for (let [duration, lastDay] of course) {
        if (time + duration <= lastDay) {
            time += duration;
            maxHeap.push(duration);
            maxHeap.sort((a, b) => b - a);
        } else {
            if (maxHeap.length > 0 && duration < maxHeap[0]) {
                time -= maxHeap[0] - duration;
                maxHeap.shift();
                maxHeap.push(duration);
                maxHeap.sort((a, b) => b - a);
            }
        }
    }

    return maxHeap.length;
}