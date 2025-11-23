var scheduleCourse = function(courses) {
    courses.sort((a, b) => a[1] - b[1]);
    const pq = new MaxPriorityQueue({ priority: x => x });
    let time = 0;

    for (const [duration, deadline] of courses) {
        if (time + duration <= deadline) {
            time += duration;
            pq.enqueue(duration);
        } else if (!pq.isEmpty() && duration < pq.front().element) {
            time -= pq.dequeue().element;
            time += duration;
            pq.enqueue(duration);
        }
    }

    return pq.size();
};