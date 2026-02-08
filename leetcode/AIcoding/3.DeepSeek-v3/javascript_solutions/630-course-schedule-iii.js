var scheduleCourse = function(courses) {
    courses.sort((a, b) => a[1] - b[1]);
    let maxHeap = new MaxPriorityQueue();
    let time = 0;

    for (let [duration, end] of courses) {
        if (time + duration <= end) {
            time += duration;
            maxHeap.enqueue(duration);
        } else if (maxHeap.size() > 0 && maxHeap.front().element > duration) {
            time += duration - maxHeap.dequeue().element;
            maxHeap.enqueue(duration);
        }
    }

    return maxHeap.size();
};